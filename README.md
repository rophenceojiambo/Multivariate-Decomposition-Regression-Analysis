# ENAR 2025 DataFest: Multivariate Decomposition Analysis

This repository will contain the code for the [ENAR 2025 DataFest](https://www.enar.org/meetings/spring2025/program/datafest_submission.cfm) submission.


## Abstract

Hypertension is a leading risk factor for morbidity and mortality, yet blood pressure control (BPC) has declined among U.S. adults in recent years. To examine the sociodemographic and clinical factors contributing to this trend, we conducted a multivariate decomposition analysis using data from three NHANES waves (2013-2020) from the CardioStats package, supplemented with additional NHANES variables. We performed multivariate logistic regression to identify factors associated with BPC and applied decomposition analysis to assess changes between 2013-2016 and 2013-2020. 
Decomposition partitions changes into endowment (shifts in characteristic distributions) and coefficient effects (shifts in associations). Age, gender, race, comorbidities, physical activity, antihypertensive use, and food security were associated with BPC. Most of the BPC decline was driven by the endowment effect, with additional contributions from coefficient effects related to age, gender, and cardiovascular disease. This approach provides a clearer understanding of the drivers behind BPC decline, helps disentangle population-level shifts from changes in effect sizes, and can guide interventions and policies. 


## Data

**Data source:** National Health and Nutrition Examination Survey [1].
**Inclusion Criteria:** Adults (>18 years) meeting American College of Cardiology hypertension criteria [2].
**Curated Dataset (CardioStats Package):** Demographics, blood pressure, hypertension status, Antihypertensive medications, Comorbidities.
**Additional Covariates:** healthcare utilization, health insurance, alcohol use, food security, poverty levels, depression, physical activity, and sleep disorder. 
Analysis Scope: Three waves of NHANES surveys: 2013-2014, 2015-2016, and 2017-2020.


## Data Analysis

**Descriptive summaries:** Population characteristics using frequencies and percentages.
**Comparative Analysis:** Used multivariate logistic regressions with survey wave as the main explanatory variable, reporting adjusted odds ratios (aOR), adjusted prevalence ratios (aPR), 95% confidence intervals, and p-values.
**Method:** Multivariate decomposition regression that separates overall change into two parts:
- **Characteristic (endowment) component:** changes in distribution of explanatory variables
- **Coefficient (effect) component:** changes in relationships between variables and blood pressure control
  
-------------------------------------------------------------
## Collaborators

[Kofi Agyabeng](https://github.com/soothe-one)

[Rophence Ojiambo](https://github.com/rophenceojiambo)

[Eteri Machavariani](https://github.com/uvarossa)

**Affiliation:** Department of Biostatistics, New York University School of Global Public Health
-------------------------------------------------------------


