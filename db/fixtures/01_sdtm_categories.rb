# DO NOT MODIFY THIS FILE, it was auto-generated.
# 
# Date: 2010-03-10T19:19:40+02:00
# Using SeedFu::Writer::SeedMany to seed SdtmCategory
# Written with the command:
#
#   /var/lib/gems/1.8/bin/rake db:sdtm:create
#
SdtmCategory.seed_many(:code,:id,[
  { :cdisc_preferred_term => 'ACN', :synonyms => 'Action Taken with Study Treatment', :definition => 'Action Taken with Study Treatment', :code => 'C66767', :nci_preferred_term => 'CDISC SDTM Action Taken with Study Treatment Terminology', :name => 'Action Taken with Study Treatment', :extensible => 'false', :read_only => 'true', :id => '1', :submission_value => 'ACN' },
  { :cdisc_preferred_term => 'OUT', :synonyms => 'Outcome of Event', :definition => 'A condition or event that is attributed to the adverse event and is the result or conclusion of the adverse event. (NCI)', :code => 'C66768', :nci_preferred_term => 'CDISC SDTM Adverse Event Outcome Terminology', :name => 'Outcome of Event', :extensible => 'false', :read_only => 'true', :id => '2', :submission_value => 'OUT' },
  { :cdisc_preferred_term => 'AGESPAN', :synonyms => 'Age Span', :definition => 'Subgroups of populations based on age. (NCI)', :code => 'C66780', :nci_preferred_term => 'CDISC SDTM Age Group Terminology', :name => 'Age Span', :extensible => 'true', :read_only => 'true', :id => '3', :submission_value => 'AGESPAN' },
  { :cdisc_preferred_term => 'AGEU', :synonyms => 'Age Unit', :definition => 'Those units of time that are routinely used to express the age of a person. (NCI)', :code => 'C66781', :nci_preferred_term => 'CDISC SDTM Age Unit Terminology', :name => 'Age Unit', :extensible => 'false', :read_only => 'true', :id => '4', :submission_value => 'AGEU' },
  { :cdisc_preferred_term => 'IECAT', :synonyms => 'Category for Inclusion/Exclusion', :definition => 'A collection of criteria on which subjects are evaluated and that must be met by all study subjects. (NCI)', :code => 'C66797', :nci_preferred_term => 'CDISC SDTM Category of Inclusion And Or Exclusion Terminology', :name => 'Category for Inclusion/Exclusion', :extensible => 'false', :read_only => 'true', :id => '5', :submission_value => 'IECAT' },
  { :cdisc_preferred_term => 'SOC', :synonyms => 'CDISC System Organ Class', :definition => 'Terms at the highest level of the CDISC system organ class terminology.', :code => 'C66783', :nci_preferred_term => 'CDISC SDTM System Organ Class Terminology', :name => 'CDISC System Organ Class', :extensible => 'false', :read_only => 'true', :id => '6', :submission_value => 'SOC' },
  { :cdisc_preferred_term => 'TOXGR', :synonyms => 'Common Terminology Criteria for Adverse Events', :definition => 'A standard terminology developed to report adverse events occurring in cancer clinical trials. Common terminology criteria for adverse events (CTCAE) are used in study adverse event summaries and Investigational New Drug reports to the Food and Drug Administration. The CTCAE contain a grading scale for each adverse event term representing the severity of the event. (NCI)', :code => 'C66784', :nci_preferred_term => 'CDISC SDTM Common Terminology Criteria for Adverse Event Grade Terminology', :name => 'Common Terminology Criteria for Adverse Events', :extensible => 'false', :read_only => 'true', :id => '7', :submission_value => 'TOXGR' },
  { :cdisc_preferred_term => 'TCNTRL', :synonyms => 'Control Type; Type of Control', :definition => 'Comparator against which the study treatment is evaluated (e.g., concurrent (placebo, no treatment, dose-response, active), external (historical, published literature).', :code => 'C66785', :nci_preferred_term => 'CDISC SDTM Control Type Terminology', :name => 'Control Type', :extensible => 'true', :read_only => 'true', :id => '8', :submission_value => 'TCNTRL' },
  { :cdisc_preferred_term => 'COUNTRY', :synonyms => 'Country', :definition => 'A collective generic term that refers here to a wide variety of dependencies, areas of special sovereignty, uninhabited islands, and other entities in addition to the traditional countries or independent states. (NCI)', :code => 'C66786', :nci_preferred_term => 'CDISC SDTM Country Terminology', :name => 'Country', :extensible => 'false', :read_only => 'true', :id => '9', :submission_value => 'COUNTRY' },
  { :cdisc_preferred_term => 'TDIGRP', :synonyms => 'Diagnosis Group', :definition => 'A grouping of individuals on the basis of a shared procedure or disease, or lack thereof (e.g. healthy volunteers, type 2 diabetic subjects, subjects with renal cell cancer). Standardized naming systems are available that define the groups within which a subject should be placed. (NCI)', :code => 'C66787', :nci_preferred_term => 'CDISC SDTM Diagnosis Group Terminology', :name => 'Diagnosis Group', :extensible => 'true', :read_only => 'true', :id => '10', :submission_value => 'TDIGRP' },
  { :cdisc_preferred_term => 'DICTNAM', :synonyms => 'Dictionary Name; Name of Dictionary', :definition => 'A name given to a reference source that lists words and gives their meaning. (NCI)', :code => 'C66788', :nci_preferred_term => 'CDISC SDTM Dictionary Name Terminology', :name => 'Dictionary Name', :extensible => 'true', :read_only => 'true', :id => '11', :submission_value => 'DICTNAM' },
  { :cdisc_preferred_term => 'ND', :synonyms => 'Not Done', :definition => 'Indicates a task, process or examination that has either not been initiated or completed. (NCI)', :code => 'C66789', :nci_preferred_term => 'CDISC SDTM Not Done Terminology', :name => 'Not Done', :extensible => 'false', :read_only => 'true', :id => '12', :submission_value => 'ND' },
  { :cdisc_preferred_term => 'ETHNIC', :synonyms => 'Ethnic Group', :definition => 'A social group characterized by a distinctive social and cultural tradition maintained from generation to generation, a common history and origin and a sense of identification with the group; members of the group have distinctive features in their way of life, shared experiences and often a common genetic heritage; these features may be reflected in their experience of health and disease. (NCI)', :code => 'C66790', :nci_preferred_term => 'CDISC SDTM Ethnic Group Terminology', :name => 'Ethnic Group', :extensible => 'true', :read_only => 'true', :id => '13', :submission_value => 'ETHNIC' },
  { :cdisc_preferred_term => 'FRM', :synonyms => 'Pharmaceutical Dosage Form; Dose Form', :definition => 'The form of the completed pharmaceutical product, e.g. tablet, capsule, injection, elixir, suppository. Dosage form can have a significant effect on the onset, duration and intensity of the pharmacological action of a drug. A pharmaceutical dosage form controls the rate at which the drug is released into the biological fluids. This release rate affects its intrinsic absorption pattern and therefore, the bioavailability of the drug.', :code => 'C66726', :nci_preferred_term => 'CDISC SDTM Pharmaceutical Dosage Form Terminology', :name => 'Pharmaceutical Dosage Form', :extensible => 'true', :read_only => 'true', :id => '14', :submission_value => 'FRM' },
  { :cdisc_preferred_term => 'NCOMPLT', :synonyms => 'Completion/Reason for Non-Completion', :definition => 'The status of the subject\'s completion of the study or a segment of the study, or the reason the subject discontinued the study or segment of the study.', :code => 'C66727', :nci_preferred_term => 'CDISC SDTM Reason for Non-Completion Terminology', :name => 'Completion/Reason for Non-Completion', :extensible => 'true', :read_only => 'true', :id => '15', :submission_value => 'NCOMPLT' },
  { :cdisc_preferred_term => 'STENRF', :synonyms => 'Relation to Reference Period', :definition => 'The name of a code list that contains terms that reference timepoints within and without a defined time period.', :code => 'C66728', :nci_preferred_term => 'CDISC SDTM Relation to Reference Period Terminology', :name => 'Relation to Reference Period', :extensible => 'false', :read_only => 'true', :id => '16', :submission_value => 'STENRF' },
  { :cdisc_preferred_term => 'ROUTE', :synonyms => 'Route of Administration', :definition => 'The course by which a substance was administered in order to reach the site of action in the body.', :code => 'C66729', :nci_preferred_term => 'CDISC SDTM Route of Administration Terminology', :name => 'Route of Administration', :extensible => 'true', :read_only => 'true', :id => '17', :submission_value => 'ROUTE' },
  { :cdisc_preferred_term => 'AESEV', :synonyms => 'Severity/Intensity Scale for Adverse Events', :definition => 'A scale that defines the degree or state of disease existing in a patient as a result of the occurrence of an adverse event. (NCI)', :code => 'C66769', :nci_preferred_term => 'CDISC SDTM Severity Intensity Scale for Adverse Event Terminology', :name => 'Severity/Intensity Scale for Adverse Events', :extensible => 'false', :read_only => 'true', :id => '18', :submission_value => 'AESEV' },
  { :cdisc_preferred_term => 'SEX', :synonyms => 'Sex', :definition => 'The assemblage of physical properties or qualities by which male is distinguished from female; the physical difference between male and female; the distinguishing peculiarity of male or female. (NCI)', :code => 'C66731', :nci_preferred_term => 'CDISC SDTM Sex of Individual Terminology', :name => 'Sex', :extensible => 'false', :read_only => 'true', :id => '19', :submission_value => 'SEX' },
  { :cdisc_preferred_term => 'SEXPOP', :synonyms => 'Sex of Participants', :definition => 'The specific sex, either male, female, or mixed of the subject group being studied. (NCI)', :code => 'C66732', :nci_preferred_term => 'CDISC SDTM Sex of Study Group Terminology', :name => 'Sex of Participants', :extensible => 'false', :read_only => 'true', :id => '20', :submission_value => 'SEXPOP' },
  { :cdisc_preferred_term => 'SIZE', :synonyms => 'Size', :definition => 'The physical magnitude of something. (NCI)', :code => 'C66733', :nci_preferred_term => 'CDISC SDTM Size Terminology', :name => 'Size', :extensible => 'true', :read_only => 'true', :id => '21', :submission_value => 'SIZE' },
  { :cdisc_preferred_term => 'DOMAIN', :synonyms => 'Domain Abbreviation', :definition => 'A unique, 2-character domain code used in the regulatory submission process. The domain abbreviation is used consistently throughout the submission, i.e. in the dataset name, as the value of the domain variable within the dataset, and as a prefix for most variable names in the dataset. (CDISC Glossary)', :code => 'C66734', :nci_preferred_term => 'CDISC SDTM Submission Domain Abbreviation Terminology', :name => 'Domain Abbreviation', :extensible => 'true', :read_only => 'true', :id => '22', :submission_value => 'DOMAIN' },
  { :cdisc_preferred_term => 'TBLIND', :synonyms => 'Trial Blinding Schema', :definition => 'The name of a code list that contains terms to define the type of blinding for the trial. (NCI)', :code => 'C66735', :nci_preferred_term => 'CDISC SDTM Trial Blinding Schema Terminology', :name => 'Trial Blinding Schema', :extensible => 'true', :read_only => 'true', :id => '23', :submission_value => 'TBLIND' },
  { :cdisc_preferred_term => 'TINDTP', :synonyms => 'Trial Indication Type', :definition => 'The name of a code list that contains terms to define the type of trial, e.g. cure or prevention. (NCI)', :code => 'C66736', :nci_preferred_term => 'CDISC SDTM Trial Indication Type Terminology', :name => 'Trial Indication Type', :extensible => 'true', :read_only => 'true', :id => '24', :submission_value => 'TINDTP' },
  { :cdisc_preferred_term => 'TPHASE', :synonyms => 'Trial Phase', :definition => 'Clinical trials are broken into three or four phases: Phase I tests a new drug or treatment for safety in a small group; Phase II expands the study to a larger group of people; Phase III expands the study to an even larger group of people to measure whether the treatment actually benefits patients, and whether its benefits exceed its risks; and Phase IV takes place after the drug or treatment has been licensed and marketed. (NCI)', :code => 'C66737', :nci_preferred_term => 'CDISC SDTM Trial Phase Terminology', :name => 'Trial Phase', :extensible => 'true', :read_only => 'true', :id => '25', :submission_value => 'TPHASE' },
  { :cdisc_preferred_term => 'TSPARMCD', :synonyms => 'Trial Summary Parameter Test Code', :definition => 'Individual characteristics of a clinical trial, e.g. description of trial design, trial blinding schema, and primary objective of trial. (NCI)', :code => 'C66738', :nci_preferred_term => 'CDISC SDTM Trial Summary Parameter Terminology by Code', :name => 'Trial Summary Parameter Test Code', :extensible => 'true', :read_only => 'true', :id => '26', :submission_value => 'TSPARMCD' },
  { :cdisc_preferred_term => 'TSPARM', :synonyms => 'Trial Summary Parameter Test Name', :definition => 'Individual characteristics of a clinical trial, e.g. description of trial design, trial blinding schema, and primary objective of trial. (NCI)', :code => 'C67152', :nci_preferred_term => 'CDISC SDTM Trial Summary Parameter Terminology by Name', :name => 'Trial Summary Parameter Test Name', :extensible => 'true', :read_only => 'true', :id => '27', :submission_value => 'TSPARM' },
  { :cdisc_preferred_term => 'TTYPE', :synonyms => 'Trial Type', :definition => 'The type of clinical trial performed e.g. efficacy, safety. (NCI)', :code => 'C66739', :nci_preferred_term => 'CDISC SDTM Trial Type Terminology', :name => 'Trial Type', :extensible => 'true', :read_only => 'true', :id => '28', :submission_value => 'TTYPE' },
  { :cdisc_preferred_term => 'VSRESU', :synonyms => 'Units for Vital Signs Results', :definition => 'The unit used to record and describe the result of a test investigating a vital sign. (NCI)', :code => 'C66770', :nci_preferred_term => 'CDISC SDTM Unit for Vital Sign Result Terminology', :name => 'Units for Vital Signs Results', :extensible => 'true', :read_only => 'true', :id => '29', :submission_value => 'VSRESU' },
  { :cdisc_preferred_term => 'VSTESTCD', :synonyms => 'Vital Signs Test Code', :definition => 'The name given to the test that analyzes a particular set of vital signs including temperature, respiratory rate, heart beat (pulse), and blood pressure. (NCI)', :code => 'C66741', :nci_preferred_term => 'CDISC SDTM Vital Sign Terminology by Code', :name => 'Vital Signs Test Code', :extensible => 'true', :read_only => 'true', :id => '30', :submission_value => 'VSTESTCD' },
  { :cdisc_preferred_term => 'VSTEST', :synonyms => 'Vital Signs Test Name', :definition => 'The name given to the test that analyzes a particular set of vital signs including temperature, respiratory rate, heart beat (pulse), and blood pressure. (NCI)', :code => 'C67153', :nci_preferred_term => 'CDISC SDTM Vital Sign Terminology by Name', :name => 'Vital Signs Test Name', :extensible => 'true', :read_only => 'true', :id => '31', :submission_value => 'VSTEST' },
  { :cdisc_preferred_term => 'NY', :synonyms => 'No Yes Response', :definition => 'A term that is used to indicate a question with permissible values of yes/no/unknown/not applicable.', :code => 'C66742', :nci_preferred_term => 'CDISC SDTM Yes No Unknown or Not Applicable Response Terminology', :name => 'No Yes Response', :extensible => 'false', :read_only => 'true', :id => '32', :submission_value => 'NY' },
  { :cdisc_preferred_term => 'LBTESTCD', :synonyms => 'Laboratory Test Code', :definition => 'Terminology used for Laboratory Tests of the CDISC Standard Data Tabulation Model.', :code => 'C65047', :nci_preferred_term => 'CDISC SDTM Laboratory Test Terminology by Code', :name => 'Laboratory Test Code', :extensible => 'true', :read_only => 'true', :id => '33', :submission_value => 'LBTESTCD' },
  { :cdisc_preferred_term => 'LBTEST', :synonyms => 'Laboratory Test Name', :definition => 'Terminology used for Laboratory Tests of the CDISC Standard Data Tabulation Model.', :code => 'C67154', :nci_preferred_term => 'CDISC SDTM Laboratory Test Terminology by Name', :name => 'Laboratory Test Name', :extensible => 'true', :read_only => 'true', :id => '34', :submission_value => 'LBTEST' },
  { :cdisc_preferred_term => 'FREQ', :synonyms => 'Frequency', :definition => 'The terminology that includes terms pertaining to frequency within CDISC.', :code => 'C71113', :nci_preferred_term => 'CDISC SDTM Frequency Terminology', :name => 'Frequency', :extensible => 'true', :read_only => 'true', :id => '35', :submission_value => 'FREQ' },
  { :cdisc_preferred_term => 'POSITION', :synonyms => 'Position', :definition => 'Terminology codelist used with Body Position within CDISC.', :code => 'C71148', :nci_preferred_term => 'CDISC SDTM Body Position Terminology', :name => 'Position', :extensible => 'true', :read_only => 'true', :id => '36', :submission_value => 'POSITION' },
  { :cdisc_preferred_term => 'EGSTRESC', :synonyms => 'ECG Result', :definition => 'Terminology codelist used with ECG Findings and Abnormalities within CDISC.', :code => 'C71150', :nci_preferred_term => 'CDISC SDTM ECG Finding Terminology', :name => 'ECG Result', :extensible => 'true', :read_only => 'true', :id => '37', :submission_value => 'EGSTRESC' },
  { :cdisc_preferred_term => 'EGTESTCD', :synonyms => 'ECG Test Code', :definition => 'Terminology codelist used with ECG Tests within CDISC.', :code => 'C71153', :nci_preferred_term => 'CDISC SDTM ECG Test Terminology by Code', :name => 'ECG Test Code', :extensible => 'true', :read_only => 'true', :id => '38', :submission_value => 'EGTESTCD' },
  { :cdisc_preferred_term => 'EGTEST', :synonyms => 'ECG Test Name', :definition => 'Terminology codelist used with ECG Test Names within CDISC.', :code => 'C71152', :nci_preferred_term => 'CDISC SDTM ECG Test Name Terminology', :name => 'ECG Test Name', :extensible => 'true', :read_only => 'true', :id => '39', :submission_value => 'EGTEST' },
  { :cdisc_preferred_term => 'EGMETHOD', :synonyms => 'ECG Test Method', :definition => 'Terminology codelist used with ECG Test Methods within CDISC.', :code => 'C71151', :nci_preferred_term => 'CDISC SDTM ECG Test Method Terminology', :name => 'ECG Test Method', :extensible => 'true', :read_only => 'true', :id => '40', :submission_value => 'EGMETHOD' },
  { :cdisc_preferred_term => 'UNIT', :synonyms => 'Unit', :definition => 'Terminology codelist used for units within CDISC.', :code => 'C71620', :nci_preferred_term => 'CDISC SDTM Unit of Measure Terminology', :name => 'Unit', :extensible => 'true', :read_only => 'true', :id => '41', :submission_value => 'UNIT' },
  { :cdisc_preferred_term => 'LOC', :synonyms => 'Anatomical Location', :definition => 'Terminology codelist used for anatomical location within CDISC.', :code => 'C74456', :nci_preferred_term => 'CDISC SDTM Anatomical Location Terminology', :name => 'Anatomical Location', :extensible => 'true', :read_only => 'true', :id => '42', :submission_value => 'LOC' },
  { :cdisc_preferred_term => 'DSCAT', :synonyms => 'Category for Disposition Event', :definition => 'Classifications that describe and group pertinent events that occur throughout the conduct of a clinical trial.', :code => 'C74558', :nci_preferred_term => 'CDISC SDTM Category For Disposition Event Terminology', :name => 'Category for Disposition Event', :extensible => 'true', :read_only => 'true', :id => '43', :submission_value => 'DSCAT' },
  { :cdisc_preferred_term => 'SKINCLAS', :synonyms => 'Skin Classification', :definition => 'A classification system used to categorize the sensitivity of a subject\'s skin to sunlight.', :code => 'C76351', :nci_preferred_term => 'CDISC SDTM Fitzpatrick Skin Classification Terminology', :name => 'Skin Classification', :extensible => 'true', :read_only => 'true', :id => '44', :submission_value => 'SKINCLAS' },
  { :cdisc_preferred_term => 'SKINTYP', :synonyms => 'Skin Type', :definition => 'A distinctive characteristic of the skin marked by the amount of sebum secreted by sebaceous glands.', :code => 'C74561', :nci_preferred_term => 'CDISC SDTM Skin Type Terminology', :name => 'Skin Type', :extensible => 'true', :read_only => 'true', :id => '45', :submission_value => 'SKINTYP' },
  { :cdisc_preferred_term => 'SCCD', :synonyms => 'Subject Characteristic Code', :definition => 'A unique code representing each Subject Characteristic.', :code => 'C74559', :nci_preferred_term => 'CDISC SDTM Subject Characteristic Code Terminology', :name => 'Subject Characteristic Code', :extensible => 'true', :read_only => 'true', :id => '46', :submission_value => 'SCCD' },
  { :cdisc_preferred_term => 'MARISTAT', :synonyms => 'Marital Status', :definition => 'A demographic parameter indicating a person\'s current conjugal status.', :code => 'C76348', :nci_preferred_term => 'Marital Status Terminology', :name => 'Marital Status', :extensible => 'true', :read_only => 'true', :id => '47', :submission_value => 'MARISTAT' },
  { :cdisc_preferred_term => 'RACE', :synonyms => 'Race', :definition => 'Terminology codelist used to identify the race of an individual within the Clinical Data Interchange Standards Consortium Study Data Tabulation Model.', :code => 'C74457', :nci_preferred_term => 'CDISC SDTM Race Terminology', :name => 'Race', :extensible => 'true', :read_only => 'true', :id => '48', :submission_value => 'RACE' },
  { :cdisc_preferred_term => 'DATEST', :synonyms => 'Drug Accountability Test Name', :definition => 'The name of the test for the drug accountability assessment.', :code => 'C78731', :nci_preferred_term => 'CDISC SDTM Drug Accountability Test Terminology by Name', :name => 'Drug Accountability Test Name', :extensible => 'true', :read_only => 'true', :id => '49', :submission_value => 'DATEST' },
  { :cdisc_preferred_term => 'DATESTCD', :synonyms => 'Drug Accountability Test Code', :definition => 'The short name, or code, of the test for the drug accountability assessment.', :code => 'C78732', :nci_preferred_term => 'CDISC SDTM Drug Accountability Test Terminology by Code', :name => 'Drug Accountability Test Code', :extensible => 'true', :read_only => 'true', :id => '50', :submission_value => 'DATESTCD' },
  { :cdisc_preferred_term => 'SPECCOND', :synonyms => 'Specimen Condition', :definition => 'The physical state or quality of a biological specimen.', :code => 'C78733', :nci_preferred_term => 'CDISC SDTM Specimen Condition Terminology', :name => 'Specimen Condition', :extensible => 'true', :read_only => 'true', :id => '51', :submission_value => 'SPECCOND' },
  { :cdisc_preferred_term => 'SPECTYPE', :synonyms => 'Specimen Type', :definition => 'The name and description of a biological specimen.', :code => 'C78734', :nci_preferred_term => 'CDISC SDTM Specimen Type Terminology', :name => 'Specimen Type', :extensible => 'true', :read_only => 'true', :id => '52', :submission_value => 'SPECTYPE' },
  { :cdisc_preferred_term => 'EVAL', :synonyms => 'Evaluator', :definition => 'The role that the individual or entity plays with respect to a specific situation or person.', :code => 'C78735', :nci_preferred_term => 'CDISC SDTM Evaluator Terminology', :name => 'Evaluator', :extensible => 'true', :read_only => 'true', :id => '53', :submission_value => 'EVAL' },
  { :cdisc_preferred_term => 'NRIND', :synonyms => 'Reference Range Indicator', :definition => 'A description of the results relative to the normal or expected range of values.', :code => 'C78736', :nci_preferred_term => 'CDISC SDTM Reference Range Indicator', :name => 'Reference Range Indicator', :extensible => 'true', :read_only => 'true', :id => '54', :submission_value => 'NRIND' },
  { :cdisc_preferred_term => 'RELTYPE', :synonyms => 'Relationship Type', :definition => 'The description of relationship types between a record or set of records.', :code => 'C78737', :nci_preferred_term => 'CDISC SDTM Relationship Type Terminology', :name => 'Relationship Type', :extensible => 'false', :read_only => 'true', :id => '55', :submission_value => 'RELTYPE' },
  { :cdisc_preferred_term => 'NCF', :synonyms => 'Never/Current/Former Classification', :definition => 'A classification of usage or experience that falls into three categories; never, current, or former.', :code => 'C78738', :nci_preferred_term => 'CDISC SDTM Never/Current/Former Classification Terminology', :name => 'Never/Current/Former Classification', :extensible => 'true', :read_only => 'true', :id => '56', :submission_value => 'NCF' }
])
# End auto-generated file.