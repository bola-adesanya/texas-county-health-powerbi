// Power Query pattern for calculating the biggest single-year pertussis jump.
// Assumes a cleaned table named FactCountyHealth with CNTY, CONAME, Year, PERTNO, and PERTRATE.

let
    Source = FactCountyHealth,
    CurrentYear = Table.SelectColumns(Source, {"CNTY", "CONAME", "Year", "PERTNO", "PERTRATE"}),
    PreviousYear = Table.SelectColumns(Source, {"CNTY", "CONAME", "Year", "PERTNO", "PERTRATE"}),
    RenamePrevious = Table.RenameColumns(
        PreviousYear,
        {
            {"Year", "PreviousYear"},
            {"PERTNO", "PreviousPERTNO"},
            {"PERTRATE", "PreviousPERTRATE"}
        }
    ),
    AddJoinYear = Table.AddColumn(RenamePrevious, "Year", each [PreviousYear] + 1, Int64.Type),
    MergePrevious = Table.NestedJoin(
        CurrentYear,
        {"CNTY", "Year"},
        AddJoinYear,
        {"CNTY", "Year"},
        "Previous",
        JoinKind.LeftOuter
    ),
    ExpandPrevious = Table.ExpandTableColumn(
        MergePrevious,
        "Previous",
        {"PreviousYear", "PreviousPERTNO", "PreviousPERTRATE"},
        {"PreviousYear", "PreviousPERTNO", "PreviousPERTRATE"}
    ),
    AddJump = Table.AddColumn(ExpandPrevious, "PertussisJump", each [PERTRATE] - [PreviousPERTRATE], type nullable number),
    FilterAtLeastTenCases = Table.SelectRows(AddJump, each [PERTNO] >= 10 and [PreviousPERTNO] >= 10),
    SortDescending = Table.Sort(FilterAtLeastTenCases, {{"PertussisJump", Order.Descending}, {"CONAME", Order.Ascending}})
in
    SortDescending
