// Power Query helper pattern for cleaning Texas county health CSV data
// Paste and adapt inside Power BI Advanced Editor.

let
    Source = Folder.Files("C:\\path\\to\\data\\raw"),
    CsvFiles = Table.SelectRows(Source, each Text.EndsWith([Extension], ".csv")),
    AddYear = Table.AddColumn(CsvFiles, "Year", each Number.FromText(Text.Select([Name], {"0".."9"})), Int64.Type),
    ImportCsv = Table.AddColumn(AddYear, "Data", each Csv.Document([Content], [Delimiter=",", Encoding=65001, QuoteStyle=QuoteStyle.Csv])),
    PromoteHeaders = Table.TransformColumns(ImportCsv, {"Data", each Table.PromoteHeaders(_, [PromoteAllScalars=true])}),
    ExpandData = Table.ExpandTableColumn(PromoteHeaders, "Data", Table.ColumnNames(PromoteHeaders[Data]{0})),
    KeepNeededColumns = Table.RemoveColumns(ExpandData, {"Content", "Extension", "Date accessed", "Date modified", "Date created", "Attributes", "Folder Path"}),
    CleanColumnNames = Table.TransformColumnNames(KeepNeededColumns, each Text.Trim(_)),
    ToNumber = (x as any) as nullable number => try Number.From(Text.Select(Text.From(x), {"0".."9", ".", "-"})) otherwise null,
    NumericColumns = {
        "TOTPOP", "POPANGPC", "POPBLPCT", "POPHISPC", "POPOTHPC",
        "POPTFMPC", "POPTMPC", "HRTDEART", "LNGCANDR", "MVDEART", "SUIDEART",
        "FSPARTIC", "POVTOT", "LIVEBIR", "LBWNO", "NOHI1864", "NOHI1864POP",
        "PERTNO", "PERTRATE", "TBNO", "SYPHNO", "GONNO", "CHLAMNO", "VARICNO", "AIDSNO",
        "LaborForce", "#UnEmp", "PercapInc"
    },
    ExistingNumericColumns = List.Intersect({NumericColumns, Table.ColumnNames(CleanColumnNames)}),
    ConvertNumbers = Table.TransformColumns(
        CleanColumnNames,
        List.Transform(ExistingNumericColumns, each {_, ToNumber, type nullable number})
    ),
    SetCountyText = Table.TransformColumnTypes(ConvertNumbers, {{"CONAME", type text}})
in
    SetCountyText
