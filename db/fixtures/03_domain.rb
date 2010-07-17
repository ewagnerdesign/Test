# DO NOT MODIFY THIS FILE, it was auto-generated.
# 
# Date: 2010-02-25T17:41:27+02:00
# Using SeedFu::Writer::Seed to seed Domain
# Written with the command:
#
#   /usr/bin/rake db:domain:create
#
Domain.seed(:code) { |s|
  s.description = 'See 6.2.1.1, assumption 1.'
  s.domain_class = 'Events'
  s.code = 'AE'
  s.name = 'Adverse Events'
}
Domain.seed(:code) { |s|
  s.description = 'Additional data about deaths, specific to findings from autopsies.'
  s.domain_class = 'Findings'
  s.code = 'AU'
  s.name = 'Autopsy'
}
Domain.seed(:code) { |s|
  s.description = 'Findings resulting from evaluations of bone mineral density.'
  s.domain_class = 'Findings'
  s.code = 'BM'
  s.name = 'Bone Mineral Density (BMD) Data'
}
Domain.seed(:code) { |s|
  s.description = 'Findings resulting from biopsies.'
  s.domain_class = 'Findings'
  s.code = 'BR'
  s.name = 'Biopsy'
}
Domain.seed(:code) { |s|
  s.description = 'See 6.1.1.1, assumption 1.'
  s.domain_class = 'Interventions'
  s.code = 'CM'
  s.name = 'Concomitant Meds'
}
Domain.seed(:code) { |s|
  s.description = 'See 5.1.2.'
  s.domain_class = 'Special Purpose'
  s.code = 'CO'
  s.name = 'Comments'
}
Domain.seed(:code) { |s|
  s.description = 'Data regarding the accountability of study drug, such as information on the receipt, dispensing, return, and packaging.'
  s.domain_class = 'Findings'
  s.code = 'DA'
  s.name = 'Drug Accountability'
}
Domain.seed(:code) { |s|
  s.description = 'Data related to the characteristics of a specific disease state under study for a subject.'
  s.domain_class = 'Findings'
  s.code = 'DC'
  s.name = 'Disease Characteristics'
}
Domain.seed(:code) { |s|
  s.description = 'Demographics includes a set of essential standard variables that describe each subject in a clinical study.  It is the parent domain for all other observations for human clinical subjects. See SDTM 2.2.6.'
  s.domain_class = 'Special Purpose'
  s.code = 'DM'
  s.name = 'Demographics'
}
Domain.seed(:code) { |s|
  s.description = 'See 6.2.2.1, assumption 1.'
  s.domain_class = 'Events'
  s.code = 'DS'
  s.name = 'Disposition'
}
Domain.seed(:code) { |s|
  s.description = 'See separate DV domain model, assumption 1.'
  s.domain_class = 'Events'
  s.code = 'DV'
  s.name = 'Protocol Deviations'
}
Domain.seed(:code) { |s|
  s.description = 'Findings resulting from electroencephalogram(EEG) tests.'
  s.domain_class = 'Findings'
  s.code = 'EE'
  s.name = 'EEG'
}
Domain.seed(:code) { |s|
  s.description = 'Findings related to the collection of ECG data,including position of the subject, method of evaluation, all cycle measurements and all findings from the ECG including an overall interpretation if collected or derived.'
  s.domain_class = 'Findings'
  s.code = 'EG'
  s.name = 'ECG'
}
Domain.seed(:code) { |s|
  s.description = 'See 6.1.2.1, assumption 1.'
  s.domain_class = 'Interventions'
  s.code = 'EX'
  s.name = 'Exposure'
}
Domain.seed(:code) { |s|
  s.description = 'Healthcare resource utilization data such as subject visits to physicians, hospitalizations, and nursing home stays.'
  s.domain_class = 'Findings'
  s.code = 'HU'
  s.name = 'Healthcare Resource Utilization'
}
Domain.seed(:code) { |s|
  s.description = 'See 6.3.2.1, assumption 1.'
  s.domain_class = 'Findings'
  s.code = 'IE'
  s.name = 'Inclusion / Exclusion'
}
Domain.seed(:code) { |s|
  s.description = 'Findings resulting from diagnostic medical imaging tests such as X-ray or MRI.'
  s.domain_class = 'Findings'
  s.code = 'IM'
  s.name = 'Imaging'
}
Domain.seed(:code) { |s|
  s.description = 'Laboratory test findings including, but is not limited to hematology, clinical chemistry and urinalysis data.  Does not include microbiology or PK data, which are stored in separate domains.'
  s.domain_class = 'Findings'
  s.code = 'LB'
  s.name = 'Laboratory Data'
}
Domain.seed(:code) { |s|
  s.description = 'Microbiology Specimen findings, including gram stain results, and organisms found.'
  s.domain_class = 'Findings'
  s.code = 'MB'
  s.name = 'Microbiology Specimens'
}
Domain.seed(:code) { |s|
  s.description = 'See 6.2.3.1, assumption 1'
  s.domain_class = 'Events'
  s.code = 'MH'
  s.name = 'Medical History'
}
Domain.seed(:code) { |s|
  s.description = 'Information regarding the subject\'s meal consumption, such as fluid intake, amounts, form (solid or liquid state), frequency, etc., typically used for PK analysis.'
  s.domain_class = 'Interventions'
  s.code = 'ML'
  s.name = 'Meal Data'
}
Domain.seed(:code) { |s|
  s.description = 'Microbiology Susceptibility Test results, plus results of any other organism-related tests.'
  s.domain_class = 'Findings'
  s.code = 'MS'
  s.name = 'Microbiology Susceptibility'
}
Domain.seed(:code) { |s|
  s.description = 'Findings from organ measurement evaluations.'
  s.domain_class = 'Findings'
  s.code = 'OM'
  s.name = 'Organ Measurements'
}
Domain.seed(:code) { |s|
  s.description = 'Concentrations of drugs/metabolites in fluids or tissues as a function of time.'
  s.domain_class = 'Findings'
  s.code = 'PC'
  s.name = 'PK Concentration'
}
Domain.seed(:code) { |s|
  s.description = 'Findings collected during a physical examination of the subject. It has findings that are discovered that are related to body systems. Does not include vital signs measurements, which are stored in the VS domain.'
  s.domain_class = 'Findings'
  s.code = 'PE'
  s.name = 'Physical Exam'
}
Domain.seed(:code) { |s|
  s.description = 'Pharmacokinetic parameters derived from pharmacokinetic concentration-time (PC) data.'
  s.domain_class = 'Findings'
  s.code = 'PP'
  s.name = 'PK Parameters'
}
Domain.seed(:code) { |s|
  s.description = 'Pharmacogenomics findings initially focusing on Genotype and Gene Expression data.'
  s.domain_class = 'Findings'
  s.code = 'PG'
  s.name = 'Pharmacogenomics'
}
Domain.seed(:code) { |s|
  s.description = 'See 6.3.5.1, assumption 1'
  s.domain_class = 'Findings'
  s.code = 'QS'
  s.name = 'Questionnaires'
}
Domain.seed(:code) { |s|
  s.description = 'See 6.3.6.1, assumption 1'
  s.domain_class = 'Findings'
  s.code = 'SC'
  s.name = 'Subject Characteristics'
}
Domain.seed(:code) { |s|
  s.description = 'See SDTM 3.3.'
  s.domain_class = ' Study Design'
  s.code = 'SE'
  s.name = 'Subject Elements'
}
Domain.seed(:code) { |s|
  s.description = 'Surgical information.'
  s.domain_class = 'Interventions'
  s.code = 'SG'
  s.name = 'Surgery'
}
Domain.seed(:code) { |s|
  s.description = 'Findings from diagnostic skin tests.'
  s.domain_class = 'Findings'
  s.code = 'SK'
  s.name = 'Skin Test'
}
Domain.seed(:code) { |s|
  s.description = 'Findings from diagnostic sleep tests (polysomnography).'
  s.domain_class = 'Findings'
  s.code = 'SL'
  s.name = 'Sleep (Polysomnography)'
}
Domain.seed(:code) { |s|
  s.description = 'Evidence of disease or condition, including objective signs and subjective symptoms that are typically observed by a physician or described to the investigator by the subject.'
  s.domain_class = 'Findings'
  s.code = 'SS'
  s.name = 'Signs and Symptoms'
}
Domain.seed(:code) { |s|
  s.description = 'Findings from exercise stress tests.'
  s.domain_class = 'Findings'
  s.code = 'ST'
  s.name = 'Stress (Exercise) Test Data'
}
Domain.seed(:code) { |s|
  s.description = 'See 6.1.3.1, assumption 1'
  s.domain_class = 'Interventions'
  s.code = 'SU'
  s.name = 'Substance Use'
}
Domain.seed(:code) { |s|
  s.description = 'See SDTM 3.3.'
  s.domain_class = ' Trial Design'
  s.code = 'SV'
  s.name = 'Subject Visits'
}
Domain.seed(:code) { |s|
  s.description = 'See SDTM 3.2.'
  s.domain_class = ' Trial Design'
  s.code = 'TA'
  s.name = 'Trial Arms'
}
Domain.seed(:code) { |s|
  s.description = 'See SDTM 3.2.'
  s.domain_class = ' Trial Design'
  s.code = 'TE'
  s.name = 'Trial Elements'
}
Domain.seed(:code) { |s|
  s.description = 'See SDTM 3.4.'
  s.domain_class = ' T rial Design'
  s.code = 'TI'
  s.name = 'Trial Inclusion/Exclusion Criteria'
}
Domain.seed(:code) { |s|
  s.description = 'See SDTM 3.5.'
  s.domain_class = ' Trial Design'
  s.code = 'TS'
  s.name = 'Trial Summary'
}
Domain.seed(:code) { |s|
  s.description = 'See SDTM 3.2.'
  s.domain_class = ' Trial Design'
  s.code = 'TV'
  s.name = 'Trial Visits'
}
Domain.seed(:code) { |s|
  s.description = 'Measurements including but not limited to blood pressure, temperature, respiration, body surface area, BMI, height and weight.'
  s.domain_class = 'Findings'
  s.code = 'VS'
  s.name = 'Vital Signs'
}
# End auto-generated file.
