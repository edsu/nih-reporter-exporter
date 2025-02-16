# nih-reporter-exporter

This repository contains a small program for downloading the contents of the [NIH Reporter Exporter]:

> ExPORTER is a key component of the NIH "open government" initiatives to provide more transparency into NIH activities, and to improve the quality and usability of data collected. ExPORTER provides bulk administrative data found in RePORTER to the public for detailed analyses or to load into their own data systems. Generally, files for downloading are provided in CSV formats. The ExPORTER FAQs page includes the data dictionary for each file, the data refresh details, and other pertinent information. CRISP was the predecessor system to RePORTER, and legacy files drawn from this system are provided from FY 1970 to FY 2009. 

You can run it by:

```
$ yarn install
$ yarn run download
downloading Abstracts
FY 2024 RePORTER Project Abstracts --> data/RePORTER_PRJABS_C_FY2024.zip
FY 2023 RePORTER Project Abstracts --> data/RePORTER_PRJABS_C_FY2023.zip
FY 2022 RePORTER Project Abstracts --> data/RePORTER_PRJABS_C_FY2022.zip
FY 2021 RePORTER Project Abstracts --> data/RePORTER_PRJABS_C_FY2021.zip
FY 2020 RePORTER Project Abstracts --> data/RePORTER_PRJABS_C_FY2020.zip
FY 2019 RePORTER Project Abstracts --> data/RePORTER_PRJABS_C_FY2019.zip
FY 2018 RePORTER Project Abstracts --> data/RePORTER_PRJABS_C_FY2018.zip
...
```

When it's done you should find the downloaded data in the `data` directory that was created.

[NIH Reporter Exporter]: https://reporter.nih.gov/exporter
