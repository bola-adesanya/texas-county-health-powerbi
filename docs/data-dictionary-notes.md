# Data dictionary notes

Key fields used in the Power BI version of the project:

| Topic | Fields |
|---|---|
| County | `CNTY`, `CONAME` |
| Population | `TOTPOP`, `POPRANK`, `POPSQMI` |
| Ethnicity | `POPANGPC`, `POPBLPCT`, `POPHISPC`, `POPOTHPC` |
| Sex | `POPTFMPC`, `POPTMPC` |
| Heart disease | `HRTDEART` |
| Lung cancer | `LNGCANDR` |
| Motor vehicle injury | `MVDEART` |
| Suicide | `SUIDEART` |
| Food assistance | `FSPARTIC` |
| Poverty | `POVTOT`, `POVPCT` |
| Low birth weight | `LBWNO`, `LBWPCT`, `LIVEBIR` |
| Insurance 18–64 | `NOHI1864`, `NOHI1864POP` |
| Pertussis | `PERTNO`, `PERTRATE` |
| Infectious disease counts | `TBNO`, `SYPHNO`, `GONNO`, `CHLAMNO`, `PERTNO`, `VARICNO`, `AIDSNO` |
| Employment | `LaborForce`, `#UnEmp`, `PercapInc`, `TOTPOP` |

Important transformation note:

The 18–64 uninsured percentage should be calculated as:

```text
NOHI1864 / NOHI1864POP
```

Do not rely on `NOHILT18` for this specific measure.
