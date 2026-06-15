# Texas County Health Analytics Dashboard — Power BI

A Power BI analytics portfolio project that transforms Texas county-level public health data into a reusable dashboard for demographic, disease, mortality, poverty, insurance, birth outcome, and employment analysis.

This repo adapts an academic biomedical informatics data-access assignment into a LinkedIn-ready analytics portfolio project. The original assignment focuses on public health CSV files and descriptive data access tasks across Texas counties.

## Portfolio value

This project demonstrates:

- Power BI data modeling and report design
- Power Query data ingestion and cleaning
- DAX measures for ranking, weighted averages, and utilization rates
- Public health analytics using county-level indicators
- Healthcare data storytelling for non-technical stakeholders
- Reproducible project documentation suitable for GitHub and LinkedIn

## Core business questions

1. Which Texas counties have the highest demographic concentrations by ethnicity and sex?
2. Which counties have the highest and lowest mortality or injury rates?
3. Which county has the highest food stamp utilization relative to poverty?
4. Which county experienced the largest single-year pertussis rate increase?
5. How does low birth weight vary across uninsured-rate bands?
6. How can selected employment indicators be extracted for secondary economic analysis?
7. How can infectious disease counts be structured for downstream JSON-based analysis?

## Repository structure

```text
texas-county-health-powerbi/
├── README.md
├── .gitignore
├── LICENSE
├── data/
│   └── README.md
├── powerbi/
│   └── README.md
├── src/
│   ├── dax/
│   │   └── measures.dax
│   └── powerquery/
│       ├── clean_county_health_data.pq
│       └── pertussis_jump_transform.pq
├── scripts/
│   └── validate_schema.py
├── docs/
│   ├── project-overview.md
│   ├── data-dictionary-notes.md
│   ├── dashboard-design.md
│   └── linkedin-post.md
├── assets/
│   └── README.md
└── outputs/
    └── README.md
```

## Power BI report pages

1. **Data Quality Overview** — row count, county count, year count, missing values
2. **County Population Explorer** — population by county and year
3. **Demographic Extremes** — highest ethnic and sex percentages by county
4. **Mortality & Injury Extremes** — high/low counties by death and injury rates
5. **Public Assistance & Birth Outcomes** — food stamp utilization and low birth weight by insurance band
6. **Infectious Disease Trends** — disease frequency trends and pertussis jump analysis
7. **Employment Extract** — XML-ready employment indicators

## Data source

The input is a folder of yearly Texas county public health CSV files with one row per county per year.

This repo does **not** include raw data by default. The CSV files are available in the local `data/raw/` folder.

## Data dictionary

The data dictionary is documented in `docs/data-dictionary-notes.md` and includes descriptions of all relevant columns.

## Key measures

The DAX file includes reusable measures for:

- Total population
- Food stamp utilization
- No-insurance rate for ages 18–64
- Low birth weight micro-average
- Top-ranked counties by demographic percentage
- Mortality and injury rate rankings

## How to use

1. Clone the repo.
2. Place yearly CSV files in `data/raw/` locally.
3. Open Power BI Desktop.
4. Use **Get Data → Folder** to load the files.
5. Apply the Power Query transformations in `src/powerquery/`.
6. Add DAX measures from `src/dax/measures.dax`.
7. Build the report pages described in `docs/dashboard-design.md`.
8. Export screenshots to `assets/` for the GitHub README.

## Contact

Questions?  

- GitHub: [github.com/bola-adesanya]
- LinkedIn: [linkedin.com/in/bola-adesanya]
- Email: [hello@bolaadesanya.com]

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.
