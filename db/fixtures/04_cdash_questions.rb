# DO NOT MODIFY THIS FILE, it was auto-generated.
# 
# Date: 2010-03-11T14:28:13+02:00
# Using SeedFu::Writer::SeedMany to seed CdashQuestion
# Written with the command:
#
#   /var/lib/gems/1.8/bin/rake db:cdash:create
#
CdashQuestion.seed_many(:domain_id,:variable_name,[
  { :variable_name => 'CMDOSFRM', :number => '11', :completion_instructions => 'Record the pharmaceutical dosage form
(e.g., tablets, capsules, syrup) of delivery for the medication taken.', :sponsor_info => 'We recognize that some drugs have
multiple forms and this field may be needed to code the drug to an ATC level. However,
in general, this level of detail should not be necessary except for medications of interest.', :sdtm_category_id => '14', :core => 'Optional', :definition => 'Name of the pharmaceutical dosage
form (e.g., tablets, capsules, syrup) of delivery for the drug.
{FRM}', :data_collection_field => 'Dose Form', :domain_id => '5' },
  { :variable_name => 'EXDOSFRM', :number => '13', :completion_instructions => 'Record the formulation (e.g., solution, tablet,
lotion) or enter the appropriate code from the code list.', :sponsor_info => 'Formulation of study treatment.
This must be collected if it can not be derived.
Variable must always be present in the underlying database.', :sdtm_category_id => '14', :core => 'Recommended /
Conditional', :definition => 'Dose form for EXTRT.
{FRM}', :data_collection_field => 'Formulation', :domain_id => '14' },
  { :variable_name => 'DSDECOD
And
DSTERM', :number => '2', :completion_instructions => 'Document the subject’s status at <insert
text corresponding to the selected trial epoch>. If the subject discontinued
prematurely, record the primary reason for
discontinuation.', :sponsor_info => 'Controlled terminology is available for
 D SDECOD, and we strongly recommend that it be used (the current, approved
 cont rolled terminology list is under
 discussion for completeness, accuracy, and extensibility).
 T he Subject Status data collection field should be presented on the CRF as a check box linked to an item from the approved controlled terminology list (DSDECOD).
 For those companies that wish to collect sponsor- and/or study-specific reasons for discontinuation (DSTERM), we recommend that these reasons be pre-printed on the CRF, with check boxes for completion wherever possible, as sub-categories of the appropriate DSDECOD item. However, we recommend limiting the use of sponsor- and study- specific reasons in order to promote consistent use of terminology and hence permit the combination of data across multiple sponsors.
 In some circumstances (e.g. DSDECOD = “Withdrawal by subject” or “Other”), where additional information may be valuable but where it may not be possible to specify sub- categories explicitly, “specify” lines may be inserted next to the appropriate controlled terminology items to permit this information to be collected.
The controlled terminology list may be filtered to omit terms that are not applicable for a study or particular milestone.2', :sdtm_category_id => '15', :core => 'Highly
Recommended', :definition => 'Standardized Disposition Term
{NCOMPLT}
And
Reported term for the Disposition Event of the subject at a selected trial epoch
Record the subject’s status at <insert text corresponding to the selected trial epoch>. If the subject discontinued prematurely, record the primary reason for discontinuation', :data_collection_field => 'Subject Status', :domain_id => '10' },
  { :variable_name => 'DSDECOD
And
DSTERM', :number => '2', :completion_instructions => 'Document the subject’s status at <insert
text corresponding to the selected trial epoch>. If the subject discontinued
prematurely, record the primary reason for
discontinuation.', :sponsor_info => 'C ontrolled terminology is available for
 D SDECOD, and we strongly recommend that it be used (the current, approved
 cont rolled terminology list is under
 di scussion for completeness, accuracy, and extensibility).
 T he Subject Status data collection field should be presented on the CRF as a check box linked to an item from the approved controlled terminology list (DSDECOD).
 For those companies that wish to collect sponsor- and/or study-specific reasons for discontinuation (DSTERM), we recommend that these reasons be pre-printed on the CRF, with check boxes for completion wherever possible, as sub-categories of the appropriate DSDECOD item. However, we recommend limiting the use of sponsor- and study- specific reasons in order to promote consistent use of terminology and hence permit the combination of data across multiple sponsors.
 In some circumstances (e.g. DSDECOD = “Withdrawal by subject” or “Other”), where additional information may be valuable but where it may not be possible to specify sub- categories explicitly, “specify” lines may be inserted next to the appropriate controlled terminology items to permit this information to be collected.
The controlled terminology list may be filtered to omit terms that are not applicable for a study or particular milestone.2', :sdtm_category_id => '15', :core => 'Highly
Recommended', :definition => 'Standardized Disposition Term
{NCOMPLT}
And
Reported term for the Disposition Event of the subject at a selected trial epoch
Record the subject’s status at <insert text corresponding to the selected trial epoch>. If the subject discontinued prematurely, record the primary reason for discontinuation', :data_collection_field => 'Subject Status', :domain_id => '10' },
  { :variable_name => 'CMROUTE', :number => '13', :completion_instructions => 'Provide the route of administration for the
drug.', :sponsor_info => 'This additional information may be
important to collect on the CRF when the sponsor would want to capture a medication’s route of administration for purposes such as coding and the medication may have more than one route. Some companies may use route in coding medications to be able to choose a precise preferred name and ATC code.', :sdtm_category_id => '17', :core => 'Recommended/
Conditional', :definition => 'Identifies the route of administration of
the drug.
{ROUTE}', :data_collection_field => 'Route', :domain_id => '5' },
  { :variable_name => 'EXROUTE', :number => '12', :completion_instructions => 'Record the route of administration (e.g., IV,
oral or transdermal) or enter the appropriate code from the code list.', :sponsor_info => 'Route of study treatment administration.
This will often be pre-printed on the CRF. This must be collected if it can not be pre- printed or derived from the protocol.', :sdtm_category_id => '17', :core => 'Recommended /
Conditional', :definition => 'Route of administration for EXTRT.
{ROUTE}', :data_collection_field => 'Route', :domain_id => '14' },
  { :variable_name => 'SEX', :number => '5', :completion_instructions => 'Record the appropriate sex (e.g., female,
male).', :sponsor_info => 'Collect the subject’s sex or gender, as
reported by subject or caretaker. This is the self-reported sex of the individual and/or is the clinician’s assignment based on a physical examination. This is a phenotypic assessment and a genotypic assessment (see Section 5.6.2 Collecting Sex, Ethnicity and Race).', :sdtm_category_id => '19', :core => 'Highly
Recommended', :definition => 'The assemblage of physical properties
or qualities by which male is distinguished from female; the physical difference between male and female; the distinguishing peculiarity of male or female (NCI – CDISC Definition).
{SEX}', :data_collection_field => 'Sex', :domain_id => '9' },
  { :variable_name => 'AEYN', :number => '1', :completion_instructions => 'Indicate if the subject experienced any
adverse events. If yes, include the appropriate details where indicated on the
CRF.', :sponsor_info => 'The intent/purpose of collecting this field is
to help with data cleaning and monitoring. It provides verification that all other fields
on the CRF were deliberately left blank.
Note: AEYN will not be included as part of the SDTMIG AE Domain for submission.', :sdtm_category_id => '32', :core => 'Optional', :definition => 'General prompt question regarding
whether or not any AEs were experienced during the study. This
provides verification that all other fields
on the CRF were deliberately left blank.


{NY}', :data_collection_field => 'Were any Adverse
Events experienced?', :domain_id => '1' },
  { :variable_name => 'AEONGO', :number => '8', :completion_instructions => 'Check the box if the adverse event has not
resolved at the time of data collection; leave the End Date blank.', :sponsor_info => 'This field will be completed to indicate that
the AE has not resolved at the time of data collection. Upon study completion, it is
expected that every reported AE should
have either an End Date or the Ongoing field will be completed, but not both.
The purpose of collecting this field is to help with data cleaning and monitoring, since this field provides further confirmation that the End Date was
deliberately left blank. The field is a special use case of “Yes/No,” containing “Yes” if
the box is checked and “No” if the box is blank and an end date is present.
This is not a direct mapping to the SDTMIG variable AEENRF. The date of data collection in conjunction with End Date and the Ongoing CDASH fields would
determine how the SDTMIG variable
AEENRF will be populated.
In some cases this information may be determined from AE Outcome.', :sdtm_category_id => '32', :core => 'Optional', :definition => 'Indicates AE is ongoing when no End
Date is provided.
{NY}', :data_collection_field => 'Ongoing', :domain_id => '1' },
  { :variable_name => 'AESER', :number => '10', :completion_instructions => 'Assess if an adverse event should be
classified as serious based on the “serious”
criteria defined in the protocol.', :sponsor_info => 'This field is related to the individual serious
adverse event type fields, which may or may not be reported on the CRF.', :sdtm_category_id => '32', :core => 'Highly
Recommended', :definition => 'Indicates whether or not the adverse
event is determined to be “serious”
based on what is defined in the protocol.
Is the Adverse Event serious?
{NY}', :data_collection_field => 'Serious Event', :domain_id => '1' },
  { :variable_name => 'AESCONG', :number => '11a', :completion_instructions => 'Record if the “serious” adverse event was
associated with congenital anomaly or birth defect.', :sponsor_info => 'If the details regarding a Serious AE need to
be collected in the clinical database, then it is recommended that a separate Yes/No
variable be defined for each Serious AE
type. In many cases sponsors will only collect the AESER field because the
individual serious adverse event types
might be collected in a separate pharmacovigilance database and therefore do not need to be collected in the clinical database.', :sdtm_category_id => '32', :core => 'Recommended/
Conditional', :definition => 'Indicates if a “serious” adverse event
was associated with a congenital anomaly or birth defect.
Is the AE associated with a congenital anomaly or birth defect?
{NY}', :data_collection_field => 'Serious Event Type -
Congenital Anomaly or Birth Defect', :domain_id => '1' },
  { :variable_name => 'AESDISAB', :number => '11b', :completion_instructions => 'Record if the “serious” adverse event
resulted in a persistent or significant disability or incapacity.', :sponsor_info => '', :sdtm_category_id => '32', :core => 'Recommended/
Conditional', :definition => 'Indicates if a “serious” adverse event
was associated with a persistent or significant disability or incapacity.
Did the AE result in a persistent or significant disability or incapacity?
{NY}', :data_collection_field => 'Serious Event Type -
Persistent or
Significant Disability or Incapacity', :domain_id => '1' },
  { :variable_name => 'AESDTH', :number => '11c', :completion_instructions => 'Record if the “serious” adverse event
resulted in death.', :sponsor_info => '', :sdtm_category_id => '32', :core => 'Recommended/
Conditional', :definition => 'Indicates if a “serious” adverse event
resulted in death.
Did the AE result in death?
{NY}', :data_collection_field => 'Serious Event Type -
Death', :domain_id => '1' },
  { :variable_name => 'AESHOSP', :number => '11d', :completion_instructions => 'Record if the “serious” adverse event
resulted in an initial or prolonged hospitalization for the patient.', :sponsor_info => '', :sdtm_category_id => '32', :core => 'Recommended/
Conditional', :definition => 'Indicates if a “serious” adverse event
resulted in an initial or prolonged hospitalization for the patient.
Did the AE result in an initial or prolonged hospitalization for the patient?
{NY}', :data_collection_field => 'Serious Event Type -
Initial or Prolonged
Hospitalization', :domain_id => '1' },
  { :variable_name => 'AESLIFE', :number => '11e', :completion_instructions => 'Record if the “serious” adverse event is life
threatening.', :sponsor_info => '', :sdtm_category_id => '32', :core => 'Recommended/
Conditional', :definition => 'Indicates if a “serious” adverse event
was life threatening.
Is the AE Life Threatening?
{NY}', :data_collection_field => 'Serious Event Type -
Life Threatening', :domain_id => '1' },
  { :variable_name => 'AESMIE', :number => '11f', :completion_instructions => 'Record if the “serious” adverse event is
associated with other serious or important medical events which may be defined in the
protocol or in the Investigator Brochure.', :sponsor_info => '(See above)', :sdtm_category_id => '32', :core => 'Recommended/
Conditional', :definition => 'Indicates if a “serious” adverse event is
associated with other serious or important medical events.
Is the AE associated with other serious or important medical events?
{NY}', :data_collection_field => 'Serious Event Type -
Other Serious or
Important Medical
Events', :domain_id => '1' },
  { :variable_name => 'AEDIS', :number => '16', :completion_instructions => 'Record if the AE caused the subject to
discontinue from the study.', :sponsor_info => 'Since the Action Taken field was defined to
only collect the changes made to the study treatment due to the AE, an additional field
was created to identify the AE(s) that
caused the subject to discontinue from the study.  Some sponsors opt to capture this
information only on the Subject Disposition CRF while others choose to collect this data on both the Subject Disposition and AE CRFs, so the specific AE term(s) and
related data can be identified.', :sdtm_category_id => '32', :core => 'Optional', :definition => 'Indication of whether the adverse event
caused the subject to discontinue from the study.
Did the AE cause the subject to discontinue from the study?
{NY}', :data_collection_field => 'Adverse Event that
Caused Study
Discontinuation', :domain_id => '1' },
  { :variable_name => 'CMYN', :number => '1', :completion_instructions => 'Indicate if the subject took any medications.
If “Yes”, include the appropriate details where indicated.', :sponsor_info => 'The intent/purpose of collecting this field is
to help with data cleaning and monitoring.
Note: CMYN will not be included as part of the SDTMIG CM Domain for submission.', :sdtm_category_id => '32', :core => 'Optional', :definition => 'General prompt question to aid in
monitoring and data cleaning.


{NY}', :data_collection_field => 'Were any medications
taken?', :domain_id => '5' },
  { :variable_name => 'CMONGO', :number => '18', :completion_instructions => 'Record the medication or therapy as
ongoing if the subject has not stopped
taking the medication or therapy at the time
of data collection and the end date should
be left blank.', :sponsor_info => 'This box should be checked to indicate that
the medication or therapy has not stopped at
the time of data collection.
At study completion, it is expected that
every reported medication or therapy should
have either End Date or be checked as
Ongoing, but not both.
This is not a direct mapping to CMENRF.
The date of data collection in conjunction
with end date and the ongoing check box
would determine how CMENRF will be
Populated.', :sdtm_category_id => '32', :core => 'Optional', :definition => 'Indicates medication or therapy is
ongoing when no End Date is provided.
{NY}', :data_collection_field => 'Mark if Ongoing', :domain_id => '5' },
  { :variable_name => 'EGPERF', :number => '1', :completion_instructions => 'Indicate whether or not ECG was done.', :sponsor_info => 'This may be implemented for an entire
ECG, or on a test-by-test basis. This is intended to be used as a data management tool to verify that results missing from the CRF are intentionally missing.
For the SDTM-based dataset, the SDTMIG variable EGSTAT can be derived from EGPERF.', :sdtm_category_id => '32', :core => 'Highly
Recommended', :definition => 'Status of whether or not ECG was
 done.
 {NY}', :data_collection_field => 'Indicate if ECG was
performed', :domain_id => '13' },
  { :variable_name => 'EGCLSIG', :number => '10', :completion_instructions => 'Record whether ECG results were clinically
significant.', :sponsor_info => 'May be included if required by the
protocol.
Could apply to specific measurements or to overall interpretation.', :sdtm_category_id => '32', :core => 'Optional', :definition => 'Whether ECG results were clinically
 significant.
Is the result clinically significant?
 {NY}', :data_collection_field => 'Clinical Significance', :domain_id => '13' },
  { :variable_name => 'IEYN', :number => '1', :completion_instructions => 'Record “Yes” if all eligibility criteria were
met for the study. Record “No” if subject did not meet all criteria at the time the subject
was enrolled.', :sponsor_info => 'This is a Yes/No question that is intended
to be used primarily as a monitoring and/or data management tool to verify
that the investigator/site reported any entry
criteria that were not met.
May be used to derive data into
IEORRES.
Must be recorded on the CRF.', :sdtm_category_id => '32', :core => 'Highly
Recommended', :definition => 'Response for whether the subject met
all the eligibility requirements for this study at the time the subject was
enrolled.
Did subject meet all eligibility criteria?
{NY}', :data_collection_field => 'Met All Eligibility
Criteria?', :domain_id => '16' },
  { :variable_name => 'MHYN', :number => '1', :completion_instructions => 'If the subject has experienced any past and /
or concomitant diseases or has had any type of surgery, select “Yes” and provide the requested information. Otherwise, select
“No” and leave the page blank.', :sponsor_info => 'Note that MHYN is not defined in the
SDTMIG MH domain. Some sponsors may find this data point useful from an administrative perspective. It should not
be included in the submission.
Also note that the sponsor may choose to collect surgical history elsewhere in the CRF.', :sdtm_category_id => '32', :core => 'Optional', :definition => 'General prompt question to aid in
monitoring and data cleaning.
Has the subject experienced any past and / or concomitant diseases or past surgeries?
{NY}', :data_collection_field => 'Has the subject
experienced any past and / or concomitant diseases or past
surgeries?', :domain_id => '20' },
  { :variable_name => 'PEYN', :number => '1', :completion_instructions => 'If physical examination was performed as
planned then select “Yes”, otherwise, select
“No”', :sponsor_info => 'A subject/page level question can be used
asking the site if the physical exam was performed at the specified time point.
If this field is used then the result should only be mapped to PESTAT in SDTMIG if the overall examination, at the subject level, was not performed. If the overall
examination was performed then the value of PESTAT would be null for the examined body systems and Not Done for any body systems not examined (see PERES).
This field is used to assist in data monitoring and cleaning', :sdtm_category_id => '32', :core => 'Optional', :definition => 'Used to indicate if the overall physical
examination was performed as scheduled.
Was the physical examination performed?
{NY}', :data_collection_field => 'Was the Physical
Examination
Performed?', :domain_id => '25' },
  { :variable_name => 'DVYN', :number => '1', :completion_instructions => 'Enter “Yes” if a protocol deviation occurred
and “No” if none occurred. Ensure that any adverse event, concomitant medication use, newly discovered medical history, etc. which triggers a protocol deviation is noted in the respective CRF.', :sponsor_info => 'May be derived in the analysis
(submission) dataset if not collected on a
CRF.', :sdtm_category_id => '32', :core => 'Optional', :definition => 'Indication of whether or not there was a
protocol deviation.
{NY}', :data_collection_field => 'Were there any
protocol deviations?', :domain_id => '11' },
  { :variable_name => 'AEACN', :number => '13', :completion_instructions => 'Record changes made to the study treatment
resulting from the adverse event.', :sponsor_info => 'CDISC controlled terminology should be
used to indicate the action taken with the study treatment in response to the AE.', :sdtm_category_id => '1', :core => 'Highly
Recommended', :definition => 'Changes made to the study treatment in
response to the adverse event.
{ACN}', :data_collection_field => 'Action Taken with
Study Treatment', :domain_id => '1' },
  { :variable_name => 'AEOUT', :number => '15', :completion_instructions => 'Record the appropriate outcome of the
event in relation to the subject’s status.', :sponsor_info => 'CDISC controlled terminology should be
used to indicate the outcome of the event as it relates to the subject’s status. The
Outcome controlled terminology includes
ICH E2B values.', :sdtm_category_id => '2', :core => 'Highly
Recommended', :definition => 'Description of the subject’s status
associated with an event.
{OUT}', :data_collection_field => 'Outcome', :domain_id => '1' },
  { :variable_name => 'AGEU', :number => '3', :completion_instructions => 'Record the appropriate age unit (e.g., years,
months, weeks, etc.).', :sponsor_info => 'If Age is captured on the CRF, the age unit
must be known to make the “Age” value meaningful. The age unit might be collected on the CRF, in those cases where the
protocol allows for any age group, or it may be pre-printed on the CRF (typically with the unit of "years").
(See Section 5.6.1 Collection of Age vs. Date of Birth)', :sdtm_category_id => '4', :core => 'Optional', :definition => 'Those units of time that are routinely
used to express the age of a person. (NCI)
{AGEU}', :data_collection_field => 'Age Units', :domain_id => '9' },
  { :variable_name => 'ETHNIC', :number => '6', :completion_instructions => 'Study participants should self-report
ethnicity, with ethnicity being asked about before race.', :sponsor_info => 'If more detailed characterizations of
ethnicity are collected to enhance data quality and consistency, it is recommended
that they be “collapsible” up to the two
categories for reportable ethnicity, as needed for reporting to FDA under its guidance.
Other regulatory bodies may expect the reporting of ethnicity values (different than the US FDA) which more appropriately reflect the population of their areas (e.g., Japanese ancestry for MHLW reporting to Japan). These may be collected as an extension to the suggested NCI-CDISC code list.', :sdtm_category_id => '13', :core => 'Recommended/
Conditional', :definition => 'A social group characterized by a
distinctive social and cultural tradition maintained from generation to
generation, a common history and origin
and a sense of identification with the group; members of the group have distinctive features in their way of life, shared experiences and often a common genetic heritage; these features may be reflected in their experience of health and disease (NCI – CDISC Definition).
{ETHNIC}', :data_collection_field => 'Ethnicity', :domain_id => '9' },
  { :variable_name => 'VSTEST', :number => '5', :completion_instructions => 'Record the name of the vital sign test if not pre-printed on the CRF.', :sponsor_info => 'It is recommended that the test names be pre-printed on the CRF.', :sdtm_category_id => '31', :core => 'Highly
Recommended', :definition => 'Verbatim name of the test or
examination used to obtain the measurement or finding.
{VSTEST}', :data_collection_field => 'Vital Sign Test Name', :domain_id => '43' },
  { :variable_name => 'LBTEST', :number => '8', :completion_instructions => 'Record the type or name of the lab test, if not pre-printed on the CRF.', :sponsor_info => 'Required to identify the test. It is recommended that the test names be pre- printed on the CRF.', :sdtm_category_id => '34', :core => 'Highly
Recommended', :definition => 'Verbatim name of the test or
examination used to obtain the measurement or finding. Note any test normally performed by a clinical laboratory is considered a lab test.
{LBTEST}', :data_collection_field => 'Test Name', :domain_id => '18' },
  { :variable_name => 'CMDOSFRQ', :number => '12', :completion_instructions => 'Record how often the medication or therapy
was taken. (e.g., BID, every other week, PRN).', :sponsor_info => 'When collected, the recommendation is to
collect dosing information in separate fields for specific and consistent data collection
and to enable programmatically utilizing
these data for analysis. See below for the rest of the dosing information components (Dose per Administration, and Unit.)', :sdtm_category_id => '35', :core => 'Optional', :definition => 'How often the medication was taken
(e.g., BID, every other week, PRN).
{FREQ}', :data_collection_field => 'Frequency', :domain_id => '5' },
  { :variable_name => 'EXDOSFRQ', :number => '11', :completion_instructions => 'Record the frequency the study treatment was
administered for a defined period of time
(e.g., BID, QID, TID).', :sponsor_info => 'Number of doses given per a specific
interval.', :sdtm_category_id => '35', :core => 'Optional', :definition => 'Usually expressed as the number of
dosings given per a specific interval.
{FREQ}', :data_collection_field => 'Frequency', :domain_id => '14' },
  { :variable_name => 'EGPOS', :number => '3', :completion_instructions => 'Record the position of the subject during the
ECG.', :sponsor_info => 'Results may be affected by whether
conditions for ECG as specified in the protocol were properly met.
One common condition is the subject\'s position (e.g., Supine, Standing).
If the protocol requires this type of information, then this question may be included to confirm that the subject\'s position matches the protocol.
The following are examples of when it is not necessary to collect these data on the CRF:
•Position of the Subject is provided as part of the electronic data, or
•Position of the Subject is not pertinent to the protocol, or
•The protocol specifies only one possible position and the sponsor does not feel there is significant risk of the sites performing the ECG with the subject in the wrong position', :sdtm_category_id => '36', :core => 'Optional', :definition => 'Position of the subject during the ECG
measurement.
What was the position of the subject during the ECG?
{POSITION}', :data_collection_field => 'Position of the
Subject', :domain_id => '13' },
  { :variable_name => 'VSPOS', :number => '11', :completion_instructions => 'Record the position of subject at time of test.', :sponsor_info => 'Position may be pre-defined as part of CRF
label or site may be given one or more options to select from.', :sdtm_category_id => '36', :core => 'Recommended/
Conditional', :definition => 'Position of the subject during a
measurement or examination.
{POSITION}', :data_collection_field => 'Position of Subject', :domain_id => '43' },
  { :variable_name => 'EGMETHOD', :number => '2', :completion_instructions => 'Record the method used to measure ECG.', :sponsor_info => 'Results may be affected by whether
conditions for ECG as specified in the protocol were properly met.
One possible condition is the method used to collect the ECG data (e.g., 12-Lead or
1-Lead).
If the protocol requires this type of information, then this question may be included to confirm that the method used matches the protocol.
The following are examples of when it is not necessary to collect these data on the CRF:
•Method of ECG is provided as part of the electronic data, or
•Method of ECG is not pertinent to the protocol, or
•The protocol specifies only one possible method for collecting ECG measurements and the sponsor does not feel there is significant risk of the sites performing the ECG using the incorrect method', :sdtm_category_id => '40', :core => 'Optional', :definition => 'Method used to measure ECG.
{EGMETHOD}', :data_collection_field => 'Method of ECG', :domain_id => '13' },
  { :variable_name => 'EGTEST', :number => '7', :completion_instructions => 'Record the name of the ECG measurement or finding, if not pre-printed on the CRF.', :sponsor_info => 'Required to identify which ECG test the result is for. If specific tests are required, these should be pre-printed on the CRF rather than collected in a field that requires the site to enter text.', :sdtm_category_id => '39', :core => 'Highly
Recommended', :definition => 'Descriptive name of the measurement or
finding.
{EGTEST}', :data_collection_field => 'Test Name', :domain_id => '13' },
  { :variable_name => 'CMDOSU', :number => '10', :completion_instructions => 'Record the dose unit of the dose of
medication taken (e.g., mg.).', :sponsor_info => 'When sponsors collect data for amount of
dose taken (i.e., “Dose”, “Total Daily
Dose”, “Unit”) must be collected as well.', :sdtm_category_id => '41', :core => 'Optional', :definition => 'This is the unit associated with the dose
of medication taken per administration of a total daily dose (e.g., "mg" in "2mg
three times per day).
{UNIT}', :data_collection_field => 'Unit', :domain_id => '5' },
  { :variable_name => 'DAORRESU', :number => '4', :completion_instructions => 'Record the units in which the study treatment was dispensed.', :sponsor_info => 'Unit of product dispensed (i.e., tablets).
The unit will need to be pre-printed on the CRF or a field provided on the CRF to capture it.', :sdtm_category_id => '41', :core => 'Highly
Recommended', :definition => 'Unit for DAORRES (i.e., tablets).
{UNIT}', :data_collection_field => 'Units of Study
Treatment Dispensed or Returned', :domain_id => '7' },
  { :variable_name => 'EGORRESU', :number => '9', :completion_instructions => 'Record the original units in which these data
were collected, if not pre-printed on CRF.', :sponsor_info => 'May be included if quantitative results
 are recorded. Because units for quantitative ECG results are typically
limited (e.g., seconds, milliseconds or
beats per minute), units should be pre- printed on the CRF rather than having the sites record the units.
This item is not necessary for qualitative results.', :sdtm_category_id => '41', :core => 'Recommended /
Conditional', :definition => 'Original units in which the data were
collected.
{UNIT}', :data_collection_field => 'Units', :domain_id => '13' },
  { :variable_name => 'EXDOSU', :number => '6', :completion_instructions => 'Record the unit of dose or amount taken per period recorded (e.g., ng, mg, or mg/kg).', :sponsor_info => 'Unit of dose or amount taken per
“constant dosing interval” recorded. Dose must be collected if it cannot be
derived via other methods (e.g., derived
from randomization data).
The unit will need to be pre-printed on the CRF or a field provided on the CRF to capture it.', :sdtm_category_id => '41', :core => 'Recommended /
Conditional', :definition => 'Units for EXDOSE.
{UNIT}', :data_collection_field => 'Dose Unit', :domain_id => '14' },
  { :variable_name => 'EXINTPU', :number => '14a', :completion_instructions => 'Record the unit (e.g., minutes, hours, days)
for the duration of treatment interruption.', :sponsor_info => 'The unit (e.g., minutes, hours, days) needs
to be collected as a qualifier to the number
for duration.', :sdtm_category_id => '41', :core => '', :definition => 'Unit for the duration of treatment interruption. {UNIT}', :data_collection_field => 'Duration of
Interruption
(including units)', :domain_id => '14' },
  { :variable_name => 'EXVOLTU', :number => '17', :completion_instructions => 'Record the unit of total volume administered/given to the subject (e.g., mL).', :sponsor_info => 'Unit of the administration volume (e.g.,mL).', :sdtm_category_id => '41', :core => 'Optional', :definition => 'The unit of measure for the exposure volume amount. {UNIT}', :data_collection_field => 'Total Volume Administered Unit', :domain_id => '14' },
  { :variable_name => 'EXFLRTU', :number => '19', :completion_instructions => 'Record the unit for the infusion rate (e.g., mL/min).', :sponsor_info => 'Unit of the infusion rate (e.g., mL/min).', :sdtm_category_id => '41', :core => 'Optional', :definition => 'The unit of measure for the rate of infusion. {UNIT}', :data_collection_field => 'Flow Rate Unit', :domain_id => '14' },
  { :variable_name => 'EXPDOSEU', :number => '23', :completion_instructions => 'Record the unit of dose or amount planned
per period (e.g., ng, mg, or mg/kg).', :sponsor_info => 'Important note:  This field must be used
in conjunction with “actual dose” EXDOSE and “actual dose units” EXDOSEU since this field captures the
unit of the planned dose rather than the dose the subject actually received.', :sdtm_category_id => '41', :core => 'Optional', :definition => 'Units for EXPDOSE.
{UNIT}', :data_collection_field => 'Planned Dose Units', :domain_id => '14' },
  { :variable_name => 'EXLOC', :number => '15', :completion_instructions => 'Record the body location where the study treatment was administered (e.g., shoulder,hip,arm).', :sponsor_info => 'Location where the study treatment was administered.', :sdtm_category_id => '42', :core => 'Optional', :definition => 'Specifies anatomical location of administration. {LOC}', :data_collection_field => 'Body Location', :domain_id => '14' },
  { :variable_name => 'VSLOC', :number => '10', :completion_instructions => 'Record or select location on body where
measurement was performed, if not pre- printed on CRF.', :sponsor_info => 'Location may be pre-defined as part of
CRF label.', :sdtm_category_id => '42', :core => 'Optional', :definition => 'Location relevant to the collection of
Vital Signs measurement. Example: LEFT ARM for blood pressure. {LOC}', :data_collection_field => 'Location of Vital Signs
Measurement', :domain_id => '43' },
  { :variable_name => 'SCTEST', :number => '1', :completion_instructions => 'Not applicable.', :sponsor_info => 'It is recommended that the questions be
pre-printed on the CRF', :sdtm_category_id => '46', :core => 'Highly
Recommended', :definition => 'Name of the subject characteristic being
queried.
{SCCD}', :data_collection_field => 'Subject Characteristic
Question', :domain_id => '29' },
  { :variable_name => 'EPOCH', :number => '1', :completion_instructions => '(Typically, the trial epoch will be pre-
printed on the CRF as the title of the page;
however, for those companies whose standard CRF module includes a “pick- list” of epochs, the following instruction is given).
Check the <epoch, or insert more appropriate wording> for which disposition is being recorded.', :sponsor_info => 'Typically, the trial epoch will be pre-
printed on the CRF as the title of the page;
however, some companies have a standard CRF module that includes a “pick-list” of epochs.
NOTE: See SDTMIG for further information regarding EPOCH.', :sdtm_category_id => '', :core => 'Recommended/
Conditional', :definition => 'Trial epoch (e.g., trial cycle, phase,
end of study, etc.) for which subject disposition is being collected.', :data_collection_field => 'Trial Epoch', :domain_id => '10' },
  { :variable_name => 'DSSTDAT', :number => '3', :completion_instructions => 'Record the date that the subject completed
the <epoch, or insert more appropriate wording> as defined in the protocol and/or CRF Completion Instructions using the
CDASH recommended collection date format. If the subject did not complete the
<epoch, or insert more appropriate wording>, record the date as defined in the
protocol and/or CRF Completion
Instructions using the CDASH- recommended date format (e.g., 08-AUG-
2008)
.', :sponsor_info => 'Define in the protocol and/or CRF
Completion Instructions the criteria for completion of each trial epoch for which a disposition CRF will be provided. Define
also the date of completion or discontinuation.
Only collect the date of completion or discontinuation on the disposition CRF module if the same information is not being collected on another CRF module. For example, if the date of the last dose is defined to mark the end of the Treatment Phase epoch, and is collected on the Exposure form, then this field would not be collected on the Disposition CRF module. If not collected elsewhere, this variable should be collected on the Disposition CRF
module.
For the SDTM-based dataset, the SDTMIG variable DSSTDTC is derived by concatenating CDASH Date and Time of Completion or Discontinuation (if time is collected) into DSSTDTC using the ISO
8601 format.', :sdtm_category_id => '', :core => 'Recommended /
Conditional', :definition => 'The date that the subject completed the
selected trial epoch, or the date that the subject discontinued from the selected trial epoch, using the CDASH
recommended collection date format.', :data_collection_field => 'Date of Completion or
Discontinuation', :domain_id => '10' },
  { :variable_name => 'DSSTTIM', :number => '4', :completion_instructions => 'Record the time (as complete as possible)
that the subject completed the selected trial
epoch as defined in the protocol and/or CRF
Completion Instructions. If the subject did
not complete the selected trial epoch, record
the time (as complete as possible) as
defined in the protocol and/or CRF
Completion Instructions.', :sponsor_info => 'Define in the protocol and/or CRF
Completion Instructions the criteria for
completion of each trial epoch for which a
disposition CRF will be provided. Define
also the date of completion or
discontinuation. Collecting the time of
completion or discontinuation is only
appropriate if it can be realistically
determined and if there is a scientific reason
for needing to know this level of detail.
Typically, it is not recommended that a time
be collected unless the subject is under the
direct care of the site at the time of the
event.
Only collect the time of completion or
discontinuation on the disposition CRF
module if the same information is not being
collected on another CRF module. For
example, if the time of the last dose is
defined to mark the end of the Treatment
Phase epoch, and is collected on the Drug
Exposure form, then this field would not be
collected on the Disposition CRF module.
For the SDTM-based dataset, the
SDTMIG variable DSSTDTC is derived by
concatenating CDASH Date and Time of
Completion or Discontinuation (if time is
collected) into DSSTDTC using the ISO
8601 format.', :sdtm_category_id => '', :core => 'Optional', :definition => 'The time that the subject completed the selected trial epoch, or the time that the
subject discontinued from the selected
trial epoch.', :data_collection_field => 'Time of Completion or Discontinuation', :domain_id => '10' },
  { :variable_name => 'AESPID', :number => '2', :completion_instructions => '•Record sequential numbers for each adverse event, beginning with “1”.
•Number sequence for all following pages should not be restarted.', :sponsor_info => 'Sponsor-defined reference number. Perhaps
pre-printed on the CRF as an explicit line identifier or defined in the sponsor’s operational database (derived) (e.g., line number on an Adverse Event page).
For paper AE CRFs, it can be beneficial to use a sequence number in a data query to clearly communicate to the site the specific record in question.', :sdtm_category_id => '', :core => 'Optional', :definition => 'A sponsor-defined reference number
associated with each unique AE record.', :data_collection_field => 'Line #', :domain_id => '1' },
  { :variable_name => 'AETERM', :number => '3', :completion_instructions => '•Record only one diagnosis, sign or symptom per line (e.g., nausea and vomiting should not be recorded in the same entry, but as 2 separate entries).
•Using accepted medical terminology, enter the diagnosis (if known); otherwise enter a sign or symptom. If a diagnosis subsequently becomes available, then this diagnosis should be entered on the AE form, replacing the original entries, where appropriate.
•Death should not be recorded as an event but should be recorded as the outcome of the event. The condition that resulted in the death should be recorded as the event.
•Do not use abbreviations.', :sponsor_info => 'In most cases, the verbatim term (i.e.,
investigator-reported term) will be coded to a standard medical dictionary such as
MedDRA, WHO ART, after the data have
been collected on the CRF. The coding data will be stored in field(s) not defined by CDASH.', :sdtm_category_id => '', :core => 'Highly
Recommended', :definition => 'Verbatim (i.e., investigator-reported
term) description of the adverse event.', :data_collection_field => 'Adverse Event', :domain_id => '1' },
  { :variable_name => 'AESTDAT', :number => '4', :completion_instructions => 'Record the date that the AE began using the
CDASH-recommended date format (e.g.,
08-AUG-2008).  Best
Practice section.', :sponsor_info => 'For the SDTM-based dataset, the
SDTMIG variable AESTDTC is derived by concatenating CDASH Start Date and Time (if time is collected) into AESTDTC using
the ISO 8601 format.', :sdtm_category_id => '', :core => 'Highly
Recommended', :definition => 'Date when the adverse event started.', :data_collection_field => 'Start Date', :domain_id => '1' },
  { :variable_name => 'AESTTIM', :number => '5', :completion_instructions => 'If appropriate, record the time (as complete
as possible) that the AE began. .', :sponsor_info => 'Collecting the time an AE was started is
only appropriate if it can be realistically determined and if there is a scientific reason
for needing to know this level of detail. An
example would be in an early phase study where the subject is under the direct care of the site at the time the event started and the study design is such that it is important to know the AE start time with respect to dosing.
For the SDTM-based dataset, the SDTMIG variable AESTDTC is derived by concatenating CDASH Start Date and Time (if time is collected) into AESTDTC using the ISO 8601 format.', :sdtm_category_id => '', :core => 'Recommended/
Conditional', :definition => 'Time when the adverse event started.', :data_collection_field => 'Start Time', :domain_id => '1' },
  { :variable_name => 'AEENDAT', :number => '6', :completion_instructions => 'Record the date that the AE resolved using
the CDASH-recommended date format
(e.g., 08-AUG-2008). .
If the AE is ongoing, leave the field blank.', :sponsor_info => 'For the SDTM-based dataset, the
SDTMIG variable AEENDTC is derived by concatenating CDASH End Date and Time
(if time is collected) into AEENDTC using
the ISO 8601 format.', :sdtm_category_id => '', :core => 'Highly
Recommended', :definition => 'Date when the adverse event resolved.', :data_collection_field => 'End Date', :domain_id => '1' },
  { :variable_name => 'AEENTIM', :number => '7', :completion_instructions => 'If appropriate, record the time (as complete
as possible) that the AE resolved.  .', :sponsor_info => 'Collecting the time an AE resolved is only
appropriate if it can be realistically determined and if there is a scientific reason
for needing to know this level of detail. An example would be in an early phase study
where the subject is under the direct care of the site at the time the event resolved and
the study design is such that it is important to know the AE end time with respect to
dosing.
For the SDTM-based dataset, the SDTMIG variable AEENDTC is derived by concatenating CDASH End Date and Time (if time is collected) into AEENDTC using the ISO 8601 format.', :sdtm_category_id => '', :core => 'Recommended/
Conditional', :definition => 'Time when the adverse event resolved.', :data_collection_field => 'End Time', :domain_id => '1' },
  { :variable_name => 'AESEV
And/or
AETOXGR', :number => '9', :completion_instructions => 'Severity: The reporting
physician/healthcare professional will assess the severity of the adverse
drug/biologic event using the sponsor-
defined categories. This assessment is subjective and the reporting physician/
healthcare professional should use medical judgment to compare the reported Adverse
Event to similar type events observed in clinical practice. Severity is not equivalent
to seriousness.
And/or
Severity CTCAE Grade: The reporting physician/healthcare professional will assess the severity of the adverse event using the toxicity grades.', :sponsor_info => 'Either AESEV or AETOXGR must appear
on the CRF. Some studies may mandate the collection of both.
Note: Completion of CTCAE grade is a mandatory field for cancer studies. In all other types of studies this is an optional field.', :sdtm_category_id => '', :core => 'Highly
Recommended', :definition => 'Description of the severity of the
adverse event.
 {AESEV}
{TOXGR}', :data_collection_field => 'Severity', :domain_id => '1' },
  { :variable_name => 'AEREL', :number => '12', :completion_instructions => 'Indicate if the cause of the adverse event is
related to the study treatment and cannot be reasonably explained by other factors (e.g.,
subject’s clinical state, concomitant
therapy, and/or other interventions).', :sponsor_info => 'Sponsored-defined terminology will be used
to indicate the relationship between the AE
and the study treatment (e.g., Yes/No or ICH E2B examples: Not Related, Unlikely Related, Possibly Related, Related).', :sdtm_category_id => '', :core => 'Highly
Recommended', :definition => 'Indication of whether the study
treatment had a causal effect on the adverse event, as reported by the
clinician/investigator.', :data_collection_field => 'Relationship to Study
Treatment', :domain_id => '1' },
  { :variable_name => 'AEACNOTH', :number => '14', :completion_instructions => 'Record all other action(s) taken resulting
from the adverse event that are unrelated to study treatment dose changes.', :sponsor_info => 'This field is usually reported as a free text
field. Example: Treatment Unblinded, Primary Care Physician Notified.', :sdtm_category_id => '', :core => 'Optional', :definition => 'Describes Other Action(s) taken in
response to the adverse event that are unrelated to study treatment dose changes.', :data_collection_field => 'Other Action Taken', :domain_id => '1' },
  { :variable_name => 'CMSPID', :number => '2', :completion_instructions => '•Record sequential numbers for each medication, beginning with “1”.
•Number sequence for all following pages should not be restarted.', :sponsor_info => 'Sponsor-defined reference number. Perhaps
pre-printed on the CRF as an explicit line identifier or defined in the sponsor’s
operational database (derived) (e.g., line
number on a concomitant medication page).
For paper Prior & Concomitant Medication CRFs, it can be beneficial to use a sequence number in a data query to clearly communicate to the site the specific record in question.', :sdtm_category_id => '', :core => 'Optional', :definition => 'A sponsor-defined reference number.', :data_collection_field => 'Line #', :domain_id => '5' },
  { :variable_name => 'CMTRT', :number => '3', :completion_instructions => '•Record only one medication per line.
•Provide the full trade or proprietary name of the drug or therapy; otherwise the generic name may be recorded.
•If a medication is used for multiple indications [i.e., multiple AEs, and/or Medical History condition(s)], list the medication again with each indication as a new line or entry.', :sponsor_info => 'In most cases, the verbatim drug names or
therapy will be coded to a standard dictionary such as WHO DRUG after the data have been collected on the CRF.
For the collection of verbatim drug name or therapy, the recommendation is to ask the sites to provide the full trade or proprietary name since it is more exact than the generic. The full trade name provides the base generic and the appropriate salt for that particular drug. In addition, for coding purposes it helps with ATC selection.
For example the medication Tylenol with codeine #1 has a different ATC code from Tylenol with codeine #3.', :sdtm_category_id => '', :core => 'Highly
Recommended', :definition => 'Verbatim drug name or therapy (type of
therapies that has similar data collection characteristics as medications.)', :data_collection_field => 'Medication / Therapy
Name', :domain_id => '5' },
  { :variable_name => 'CMINGRD', :number => '4', :completion_instructions => '•Prior to a subject’s clinical visit, remind all subjects to bring all medications bottles, packs etc. they are taking with them to
their clinical visit.
•Record all active ingredient(s) off the medication label and separate each ingredient with a comma for the name of drug medication or therapy taken.
For example, the medication Dolmen, if manufactured in Spain, the active ingredients should be reported as noted below:
Active Ingredient: Acetylsalicylic Acid, Ascorbic acid, codeine phosphate', :sponsor_info => 'This may be collected in addition to the
“Medication / Therapy Name”. Collecting this provides more detailed information
when coding to a medication dictionary like
WHO Drug Enhanced format C which now codes to the ingredient level for many trade named medication.
For example, the medication Dolmen, depending on the country where it is manufactured, the active ingredients may be different.
Spain: Acetylsalicylic Acid, Ascorbic acid, codeine phosphate
Italy and Czech Republic: contains
Tenoxicam
Estonia and Latvia: contains Dexketoprofen trometamol', :sdtm_category_id => '', :core => 'Optional', :definition => 'Medication Ingredients.', :data_collection_field => 'Active Ingredient(s)', :domain_id => '5' },
  { :variable_name => 'CMINDC', :number => '5', :completion_instructions => '•Record the reason the medication was taken base on clinical investigator’s evaluation.
•If taken to treat a condition, and a diagnosis was made, the indication should be the diagnosis.
•If taken to treat a condition, and no diagnosis was made, the indication should be the signs and symptoms.
•If taken as prophylaxis, we recommend reporting as “Prophylaxis for…”.', :sponsor_info => 'This additional information is collected on
the CRF when the sponsor would want to capture the reason(s) why a subject took a medication.
This information can then be used as deemed appropriate for coding, analysis (i.e., in the classification of medications), for reconciling the medications taken by a subject with their provided medical history and/or AEs/SAEs as part of the data clean- up and monitoring process, etc.', :sdtm_category_id => '', :core => 'Recommended/
Conditional', :definition => 'The reason for administration of a
concomitant (non-study) medication.
(e.g., Nausea, Hypertension)
This is not the pharmacological/ therapeutic classification of an agent (e.g., antibiotic, analgesic, etc.), but the reason for its administration to the subject.', :data_collection_field => 'Indication', :domain_id => '5' },
  { :variable_name => 'CMAENO', :number => '6', :completion_instructions => '•Record the AE line number of the Adverse
Event for which this medication was taken. The AE line number is located on
the Adverse Events CRF.
•If the medication is taken for multiple indications (i.e., multiple AEs, or Medical History condition), list the medication again with each indication as a new line or entry.', :sponsor_info => 'Intent is to establish a link between the
adverse event and the medication taken for the adverse event, but there may be other
ways to collect this type of information.
Utilizing this variable to maintain a link to a sequence number associated with an AE
may result in unnecessary data cleaning work. Potential reconciliation issues occur for example, if the AE line number is deleted or a new AE is added due to a query
response or a correction by the clinical site or an AE verbatim is split for coding.
Note: CMAENO will not be included in the
SDTMIG CM domain in submissions.', :sdtm_category_id => '', :core => 'Optional', :definition => 'Identifier for the adverse event that is
the indication for this medication.', :data_collection_field => 'AE Line #', :domain_id => '5' },
  { :variable_name => 'CMMHNO', :number => '7', :completion_instructions => '•Record the MH line number of the medical history event for which this medication
was taken. The MH line number is located on the Medical History CRF.
•If the medication is taken for multiple indications (i.e., multiple AEs, or Medical History condition), list the medication again with each indication as a new line or entry.', :sponsor_info => 'Intent is to establish a link between the
medical history condition and the medication taken for the medical history condition, but there may be other ways to
collect this type of information.
Utilizing this variable to maintain a link to a sequence number associated with an MH condition may result in unnecessary data cleaning work. Potential reconciliation
issues occur for example, if the MH line number is deleted or a new MH is added
due to a query response or a correction by
the clinical site or an MH verbatim is split for coding.
Note: CMMHNO will not be included in the
SDTMIG CM domain in submissions.', :sdtm_category_id => '', :core => 'Optional', :definition => 'Identifier for the medical history
condition that is the indication for this medication.', :data_collection_field => 'MH Line #', :domain_id => '5' },
  { :variable_name => 'CMDSTXT', :number => '8', :completion_instructions => 'Record the dose of medication taken per
 administration (e.g., 200).
Please do not record a dosing range (e.g.,
200-400) for dose.', :sponsor_info => 'Where this level of dosing information is
required by a sponsor, this field may be included.
Defining this data collection field as a dose text field allows for flexibility in capturing text dose entries.
CMDSTXT is not a direct mapping to the SDTMIG variable CMDOSTXT. The data collected in this dose text-format field need to be separated or mapped to either SDTMIG CMDOSE if numeric or CMDOSTXT if text.', :sdtm_category_id => '', :core => 'Optional', :definition => 'The dose of medication taken per
 administration.', :data_collection_field => 'Dose', :domain_id => '5' },
  { :variable_name => 'CMDOSTOT', :number => '9', :completion_instructions => 'Record the total dose of medication taken
daily.', :sponsor_info => 'In some clinical trials (such as Phase I),
individual doses are more likely to be collected. In clinical trials when dosing data
do not need to be that precise, e.g., in later
phase trials (such as Phase IV/post marketing trials), the total daily dose may
be all that is collected.
For general medication, it is not recommended to use “Total Daily Dose”. Instead, this can be calculated or derived from other fields such as Units, Dose, and Frequency to avoid confusion and calculation by the clinical site.', :sdtm_category_id => '', :core => 'Optional', :definition => 'Total daily dose taken.', :data_collection_field => 'Total Daily Dose', :domain_id => '5' },
  { :variable_name => 'CMSTDAT', :number => '14', :completion_instructions => '•Record the date the medication or therapy was first taken using the CDASH- recommended date format (e.g., 08-AUG-
2008).  Best
Practice section.
•If the subject has been taking the medication for a considerable amount of time prior to the start of the study, it is acceptable to have an incomplete date. Medications taken during the study are expected to have a complete start date.
•Prior medications that are exclusionary should have both a start and end date', :sponsor_info => 'The preferred method is to collect a
complete Start Date. Partial dates (i.e., providing year only) for medications started a considerable amount of time prior to the start of study are acceptable.
For the SDTM-based dataset, the SDTMIG variable CMSTDTC is derived by concatenating CDASH Start Date and Time (if time is collected) into CMSTDTC using the ISO 8601 format.', :sdtm_category_id => '', :core => 'Highly
Recommended', :definition => 'Date when the medication was first
taken.', :data_collection_field => 'Start Date', :domain_id => '5' },
  { :variable_name => 'CMPRIOR', :number => '15', :completion_instructions => 'Indicate if this medication or therapy was
started before the study or during the study.', :sponsor_info => 'If instead of Start Date, information such as
BEFORE or DURING or AFTER is collected, this information is derived in the CMSTRF variable.', :sdtm_category_id => '', :core => 'Recommended/
Conditional', :definition => 'To determine if medications were taken
prior to study start.', :data_collection_field => 'Mark if taken prior to
study', :domain_id => '5' },
  { :variable_name => 'CMSTTIM', :number => '16', :completion_instructions => 'Record the time (as complete as possible) that the medication or therapy was started. .', :sponsor_info => 'Recommend collecting the time a medication was started when a protocol or data collection scenarios supports it. Typically, a start time is not collected
unless the subject is under the direct care of the site at the time a medication is taken.
For the SDTM-based dataset, the SDTMIG variable CMSTDTC is derived by concatenating CDASH Start Date and Time (if time is collected) into CMSTDTC using the ISO 8601 format.', :sdtm_category_id => '', :core => 'Recommended/ Conditional', :definition => 'Time the medication was started.', :data_collection_field => 'Start Time', :domain_id => '5' },
  { :variable_name => 'CMENDAT', :number => '17', :completion_instructions => 'Record the date the subject stopped taking the medication or therapy using the CDASH-recommended date format (e.g.,
08-AUG-2008).  Best
Practice section.
If the subject has not stopped taking the medication leave this field blank.', :sponsor_info => 'The assumption is that sponsors should
either have a complete end date or will
indicate that the medication or therapy was
ongoing at the end of the study.
For the SDTM-based dataset, the
SDTMIG variable CMENDTC is derived
by concatenating CDASH End Date and
Time (if time is collected) into CMENDTC
using the ISO 8601 format.', :sdtm_category_id => '', :core => 'Recommended/ Conditional', :definition => 'Date that the subject stopped taking the medication or therapy.', :data_collection_field => 'End Date', :domain_id => '5' },
  { :variable_name => 'CMENTIM', :number => '19', :completion_instructions => 'Record the time (as complete as possible)
that the medication was stopped. .', :sponsor_info => 'Recommend collecting the time a
medication was ended when a protocol or data collection scenarios supports it.
Typically, an end time is not collected unless the subject is under the direct care of the site at the time a medication is stopped.
For the SDTM-based dataset, the SDTMIG variable CMENDTC is derived by concatenating CDASH End Date and Time (if time is collected) into CMENDTC using the ISO 8601 format.', :sdtm_category_id => '', :core => 'Recommended/
Conditional', :definition => 'Time when the subject stopped taking
the medication or therapy.', :data_collection_field => 'End Time', :domain_id => '5' },
  { :variable_name => 'BRTHDAT', :number => '1', :completion_instructions => 'Record the date of birth to the level of
precision known (e.g., day/month/year, year, month/year, etc).', :sponsor_info => 'The sponsor may choose to database as a
single variable BRTHDAT or separate
variables for each temporal component of
the date/time.
If subject has provided written authorization
(i.e., informed consent) for the reporting of
personal information, we consider the
reporting of a full and accurate date of birth
appropriate. This approach is generally
consistent with the privacy laws of most
countries.
See the Additional Information for
Sponsors for each of the temporal
components (rows 1a-1d) below.
Below are some examples of complete and
reduced precision when recording date of
birth:
• Subjects without birth records might only
be able to provide their date of birth to the
decade level (reduced precision -
imputation may be needed for analyses).
• Subjects in countries where privacy rules
preclude the collection of personal data
containing more detail than the year of
birth might only provide date of birth data
to the year level (reduced precision -
imputation may be needed for analyses).
Note: It is recommended that the CRF
should be modified for sites in these
counties to prevent the clinician from
entering the data that would violate the
privacy rule (i.e., gray out the month and
day fields on paper or make them
inaccessible for entry in an EDC system). • Subjects in most studies would provide
date of birth data to the day level of
precision. This would provide the
expected level of detail to perform agerelated
analyses (expected precision for
analyses requirements).
• In studies where the analyses would
require more precise knowledge of age,
such as pediatric, natal or neo-natal
studies, it would be necessary to collect
date of birth data to the hour level, even in
countries with privacy constraints
(expected precision for analyses
requirements). Note: Appropriate written
authorization from parent or guardian (i.e.,
informed consent) as well as IAB and
DPA (Data Protection Authority)
approvals may be required in these cases.
It is expected that what is collected for
BRTHDAT is reported for the SDTM
BRTHDTC in the ISO 8601 format. If data
are collected In a manner resulting in one of
the reduced precision levels noted above,
then the reported AGE (SDTM required
variable), if not collected on the CRF,
should be derived using a documented
algorithm that describes how the age was
derived and/or imputed for those birth dates
collected with reduced precision.
(See Section 5.6.1 Collection of Age vs.
Date of Birth and also Section 3.4. FAQs on
Best Practices for Creating Data Collection
Instruments)', :sdtm_category_id => '', :core => 'Highly
Recommended', :definition => 'A subject’s date of birth (with or
without the time of birth). The complete
Date of Birth is made from the temporal components of Birth Year, Birth Month, Birth Day and Birth Time.', :data_collection_field => 'Date of Birth (and
time)', :domain_id => '9' },
  { :variable_name => 'BRTHYR', :number => '1a', :completion_instructions => 'Record the subject’s year of birth (e.g.,
YYYY, a four digit year).', :sponsor_info => 'Year of Birth is the collected variable used
for recording the year component of the
“Date of Birth”.
(See Section 5.6.1 Collection of Age vs. Date of Birth and also Section 3.4. FAQs on Best Practices for Creating Data Collection Instruments)', :sdtm_category_id => '', :core => 'Highly
Recommended', :definition => 'Year of the subject’s birth.', :data_collection_field => 'Year of Birth', :domain_id => '9' },
  { :variable_name => 'BRTHMO', :number => '1b', :completion_instructions => 'Record the subject’s month of birth [e.g.,
(in local language short month format)
(JAN-DEC) or (ENE-DIE) or (JAN-DEZ),
Etc.].', :sponsor_info => 'Month of Birth is the collected variable
used for recording the month component of
the “Date of Birth”.
The month of birth should be collected
unless an Ethics Committee or local Data
Protection Authorities (DPA) disagrees with
the collection of the complete date of birth
due to privacy concerns. In this case it
might be best to omit this component of the
“Date of Birth” to assuage those concerns.
(See Section 5.6.1 Collection of Age vs.
Date of Birth and also Section 3.4. FAQs on
Best Practices for Creating Data Collection
Instruments)', :sdtm_category_id => '', :core => 'Recommended/
Conditional', :definition => 'Text value for the month of the subject’s birth.', :data_collection_field => 'Month of Birth', :domain_id => '9' },
  { :variable_name => 'BRTHDY', :number => '1c', :completion_instructions => 'Record the subject’s day of birth (e.g.,
01-31).', :sponsor_info => 'Day of Birth is the collected variable used
for recording the day component of the
“Date of Birth”.
The day of birth should be collected unless
an Ethics Committee or local Data
Protection Authorities (DPA) disagrees with
the collection of the complete date of birth
due to privacy concerns. In this case it
might be best to omit this component of the
“Date of Birth” to assuage those concerns.
(See Section 5.6.1 Collection of Age vs.
Date of Birth and also Section 3.4. FAQs on
Best Practices for Creating Data Collection
Instruments)', :sdtm_category_id => '', :core => 'Recommended/
Conditional', :definition => 'Numeric day of the month of the subject’s birth.', :data_collection_field => 'Day of Birth', :domain_id => '9' },
  { :variable_name => 'BRTHTIM', :number => '1d', :completion_instructions => 'Record the time of birth (as completely as
Possible).', :sponsor_info => 'The level of detail collected by Time of
Birth may be necessary for analysis for
some pediatric, natal or neonatal studies.
(See Section 5.6.1 Collection of Age vs.
Date of Birth and also Section 3.4. FAQs on
Best Practices for Creating Data Collection
Instruments)', :sdtm_category_id => '', :core => 'Optional', :definition => 'Time of subject’s birth.', :data_collection_field => 'Time of Birth', :domain_id => '9' },
  { :variable_name => 'AGE', :number => '2', :completion_instructions => 'Record age of the subject.', :sponsor_info => 'If Age is collected, it should be collected as
a number and, to be correctly interpreted, the age value needs to be associated to a
variable for the Age Unit. It may be
necessary to know when the age was collected as an age may need to be recalculated for analysis, such as deriving age at a reference start time (RFSTDTC for SDTM). If AGE is collected, then it is recommended that the date of collection also be recorded, either separately or by association to the date of the visit.
(See Section 5.6.1 Collection of Age vs. Date of Birth)', :sdtm_category_id => '', :core => 'Optional', :definition => 'Numeric age of subject.', :data_collection_field => 'Age', :domain_id => '9' },
  { :variable_name => 'DMDAT', :number => '4a', :completion_instructions => 'Record the date the demographics data were
collected in the CDASH-recommended date format (e.g., 08-AUG-2008).', :sponsor_info => 'The date of collection may be derived from
the date of visit and if so, a separate date field is not needed.
For the SDTM-based dataset, the SDTMIG variable DMDTC is derived by formatting the CDASH Date of collection into DMDTC using the ISO 8601 format.
(See AGE Additional Information for
Sponsors.)', :sdtm_category_id => '', :core => 'Recommended/
Conditional', :definition => 'Date of collection.', :data_collection_field => 'Today\'s date', :domain_id => '9' },
  { :variable_name => 'RACE', :number => '7', :completion_instructions => 'Study participants should self-report race,
with race being asked about after ethnicity.
(The FDA guidance suggests “that individuals be permitted to designate a multiracial identity”. “Check all that apply” at the time of collection.)', :sponsor_info => 'The categories listed in the FDA Guidance
are as follows:
-American Indian or Alaska Native
-Asian
-Black or African American*
-Native Hawaiian or Other Pacific Islander
 - White
*For studies where data are collected outside the US, the recommended categories are the same except for “Black” instead of “Black or African American”.
If more detailed characterizations of race or ethnicity are collected to enhance data quality and consistency, it is recommended that they be “collapsible” up to the five minimum designations for race, as well as the two categories for reportable ethnicity, as needed for reporting to FDA under its guidance. When more detailed categorizations are desired, the use of race and vocabulary tables located within Health Level Seven’s Reference Information
Model Structural Vocabulary Tables is recommended, as they are designed to
collapse up in this manner.', :sdtm_category_id => '', :core => 'Recommended/
Conditional', :definition => 'An arbitrary classification based on
physical characteristics; a group of persons related by common descent or
heredity (U.S. Center for Disease
Control).', :data_collection_field => 'Race', :domain_id => '9' },
  { :variable_name => 'EPOCH', :number => '1', :completion_instructions => '(Typically, the trial epoch will be pre-
printed on the CRF as the title of the page;
however, for those companies whose standard CRF module includes a “pick- list” of epochs, the following instruction is given).
Check the <epoch, or insert more appropriate wording> for which disposition is being recorded.', :sponsor_info => 'Typically, the trial epoch will be pre-
printed on the CRF as the title of the page;
however, some companies have a standard CRF module that includes a “pick-list” of epochs.
NOTE: See SDTMIG for further information regarding EPOCH.', :sdtm_category_id => '', :core => 'Recommended/
Conditional', :definition => 'Trial epoch (e.g., trial cycle, phase,
end of study, etc.) for which subject disposition is being collected.', :data_collection_field => 'Trial Epoch', :domain_id => '10' },
  { :variable_name => 'DSSTDAT', :number => '3', :completion_instructions => 'Record the date that the subject completed
the <epoch, or insert more appropriate wording> as defined in the protocol and/or CRF Completion Instructions using the
CDASH recommended collection date format. If the subject did not complete the
<epoch, or insert more appropriate wording>, record the date as defined in the
protocol and/or CRF Completion
Instructions using the CDASH- recommended date format (e.g., 08-AUG-
2008)
.', :sponsor_info => 'Define in the protocol and/or CRF
Completion Instructions the criteria for completion of each trial epoch for which a disposition CRF will be provided. Define
also the date of completion or discontinuation.
Only collect the date of completion or discontinuation on the disposition CRF module if the same information is not being collected on another CRF module. For example, if the date of the last dose is defined to mark the end of the Treatment Phase epoch, and is collected on the Exposure form, then this field would not be collected on the Disposition CRF module. If not collected elsewhere, this variable should be collected on the Disposition CRF
module.
For the SDTM-based dataset, the SDTMIG variable DSSTDTC is derived by concatenating CDASH Date and Time of Completion or Discontinuation (if time is collected) into DSSTDTC using the ISO
8601 format.', :sdtm_category_id => '', :core => 'Recommended /
Conditional', :definition => 'The date that the subject completed the
selected trial epoch, or the date that the subject discontinued from the selected trial epoch, using the CDASH
recommended collection date format.', :data_collection_field => 'Date of Completion or
Discontinuation', :domain_id => '10' },
  { :variable_name => 'DSSTTIM', :number => '4', :completion_instructions => 'Record the time (as complete as possible) that the subject completed the selected trial 
epoch as defined in the protocol and/or CRFCompletion Instructions. If the subject did 
not complete the selected trial epoch, record the time (as complete as possible) as 
defined in the protocol and/or CRF Completion Instructions. 
.', :sponsor_info => 'Define in the protocol and/or CRF
Completion Instructions the criteria for
completion of each trial epoch for which a
disposition CRF will be provided. Define
also the date of completion or
discontinuation. Collecting the time of
completion or discontinuation is only
appropriate if it can be realistically
determined and if there is a scientific reason
for needing to know this level of detail.
Typically, it is not recommended that a time
be collected unless the subject is under the
direct care of the site at the time of the
event.
Only collect the time of completion or
discontinuation on the disposition CRF
module if the same information is not being
collected on another CRF module. For
example, if the time of the last dose is
defined to mark the end of the Treatment
Phase epoch, and is collected on the Drug
Exposure form, then this field would not be
collected on the Disposition CRF module.
For the SDTM-based dataset, the
SDTMIG variable DSSTDTC is derived by
concatenating CDASH Date and Time of
Completion or Discontinuation (if time is
collected) into DSSTDTC using the ISO
8601 format.', :sdtm_category_id => '', :core => 'Optional', :definition => 'The time that the subject completed the selected trial epoch, or the time that the subject discontinued from the selected trial epoch.', :data_collection_field => 'Time of Completion or Discontinuation', :domain_id => '10' },
  { :variable_name => 'DSUNBLND', :number => '5', :completion_instructions => 'Was the subject’s treatment assignment
unblinded by the site?', :sponsor_info => 'None', :sdtm_category_id => '', :core => 'Optional', :definition => 'Identifies in a blinded trial whether or not the subject’s blind was broken by the site.
Was the subject’s treatment assignment unblinded by the site?', :data_collection_field => 'Was treatment unblinded by the site?', :domain_id => '10' },
  { :variable_name => 'DSCONT', :number => '6', :completion_instructions => 'To the best of your knowledge, record if the
subject will be continuing to <the next
phase of this trial or another related trial>
(sponsor to specify as appropriate).', :sponsor_info => 'Sponsor should specify what the next phase of the trial or the related trial is.', :sdtm_category_id => '', :core => 'Optional', :definition => 'Plan for subject continuation to the next phase of the trial or another related trial at the time of completion of the CRF.', :data_collection_field => 'Will the subject continue?', :domain_id => '10' },
  { :variable_name => 'DSNEXT', :number => '7', :completion_instructions => 'Record the trial <epoch or trial identifier>
(sponsor to specify as appropriate) if the
subject is continuing.', :sponsor_info => 'Sponsor should specify what the next phase
of the trial or the related trial is.', :sdtm_category_id => '', :core => 'Optional', :definition => 'Identifies the trial epoch or new trial in which the subject will participate.', :data_collection_field => 'Next trial epoch or new trial subject will be entering', :domain_id => '10' },
  { :variable_name => 'DADDAT', :number => '1', :completion_instructions => 'Record the exact date the study treatment
was dispensed, using the CDASH- recommended date format (e.g., 08-AUG-
2008).  Best Practice
section.', :sponsor_info => 'The date study treatment dispensed should
be recorded for each dispensation for a study with multiple periods or multiple
products dispensed.
For the SDTM-based dataset, the SDTMIG variable DADTC is derived by putting the CDASH Date Study Treatment Dispensed into DADTC using the ISO
 8601 format.', :sdtm_category_id => '', :core => 'Recommended /
Conditional', :definition => 'Date the study treatment was dispensed.', :data_collection_field => 'Date Study Treatment
Dispensed', :domain_id => '7' },
  { :variable_name => 'DATEST', :number => '2', :completion_instructions => 'Not applicable.', :sponsor_info => 'Note: DATEST must be used in concert
with DAORRES and DAORRESU to describe these distinct pieces of data.', :sdtm_category_id => '', :core => 'Highly
Recommended', :definition => 'Verbatim name, corresponding to the
topic variable, of the test or examination used to obtain the drug accountability assessment (e.g., dispensed, returned).
{DATEST and DATESTCD} (See
Section 2.2.)', :data_collection_field => 'Study Treatment
Dispensed or Returned', :domain_id => '7' },
  { :variable_name => 'DAORRES', :number => '3', :completion_instructions => 'Record the actual amount of study treatment dispensed.', :sponsor_info => 'For a study with multiple periods or
multiple products dispensed, drug accountability should be assessed for each
dispensation. In this case, a sequence
number or a group ID should be used to tie together a block of related records and to link dispensed product to returned product.', :sdtm_category_id => '', :core => 'Highly
Recommended', :definition => 'Result of the Drug Accountability
assessment as originally dispensed (i.e., actual amount).', :data_collection_field => 'Results of Study
Treatment Dispensed or Returned', :domain_id => '7' },
  { :variable_name => 'DARDAT', :number => '5', :completion_instructions => 'Record the exact date the study treatment
was returned, using the CDASH- recommended date format (e.g., 08-AUG-
2008). .', :sponsor_info => 'The date study treatment returned should
be recorded for each dispensation for a study with multiple periods or multiple products dispensed. If there is only one dose dispensed at a single time the collection of this data are not applicable.
For the SDTM-based dataset, the SDTMIG variable DADTC is derived by putting the CDASH Date Study Treatment Returned into DADTC using the ISO 8601 format.', :sdtm_category_id => '', :core => 'Recommended /
Conditional', :definition => 'Date that the study treatment was
returned.', :data_collection_field => 'Date Study Treatment
Returned', :domain_id => '7' },
  { :variable_name => 'DACAT', :number => '6', :completion_instructions => 'Record the type of study treatment
dispensed/returned (i.e., Study Medication, Comparator, Placebo).', :sponsor_info => 'Not applicable.', :sdtm_category_id => '', :core => 'Optional', :definition => 'Used to define a categorization level for
a group of related records.', :data_collection_field => 'Study Treatment
Category', :domain_id => '7' },
  { :variable_name => 'DASCAT', :number => '7', :completion_instructions => 'Record the name of the study treatment
dispensed/returned (i.e., Drug A, Drug B, Placebo).', :sponsor_info => 'Not applicable.', :sdtm_category_id => '', :core => 'Optional', :definition => 'Used to define a further categorization
level for a group of related records.', :data_collection_field => 'Study Treatment Sub-
category', :domain_id => '7' },
  { :variable_name => 'EGDAT', :number => '4', :completion_instructions => 'Record the date ECG was done using the
CDASH-recommended date format (e.g.,
08-AUG-2008).
.', :sponsor_info => 'A complete date is expected for ECGs
that occur during the study.
The date of collection may be derived from the date of visit and if so, a separate assessment date field is not required.
For the SDTM-based dataset, the SDTMIG variable EGDTC is derived by concatenating CDASH Start Date and Time (if time is collected) into EGDTC using the ISO 8601 format.', :sdtm_category_id => '', :core => 'Highly
Recommended', :definition => 'Date of ECG.', :data_collection_field => 'Date of ECG', :domain_id => '13' },
  { :variable_name => 'EGTPT', :number => '5', :completion_instructions => 'Record the time point labels for when the
ECG test should be taken, if not pre-printed on the CRF.', :sponsor_info => 'Planned time point would be needed to
differentiate for multiple sequential assessments.
It is recommended that time points should be pre-printed on the CRF rather than collected in a field that requires the site to enter text.
If ECG is not being done at multiple time points within a visit, do not include this item on the CRF.', :sdtm_category_id => '', :core => 'Recommended /
Conditional', :definition => 'Text description of planned time point
when measurements should be taken for use when multiple sequential
assessments are done.', :data_collection_field => 'Planned Time Point', :domain_id => '13' },
  { :variable_name => 'EGTIM', :number => '6', :completion_instructions => 'Record the time the ECG was done (as
complete as possible).
.', :sponsor_info => 'Especially important when multiple
assessments are done on one day.
For the SDTM-based dataset, the SDTMIG variable EGDTC is derived by concatenating CDASH Date and Time of ECG (if time is collected) into EGDTC using the ISO 8601 format.', :sdtm_category_id => '', :core => 'Recommended /
Conditional', :definition => 'Time of ECG.', :data_collection_field => 'Time of ECG', :domain_id => '13' },
  { :variable_name => 'EGORRES', :number => '8', :completion_instructions => 'Record test results, interpretations or
findings.', :sponsor_info => 'Both quantitative results and interpretive
findings or summaries may be recorded here.', :sdtm_category_id => '', :core => 'Highly
Recommended', :definition => 'Result of the measurement or finding as
originally received or collected.', :data_collection_field => 'Test Result', :domain_id => '13' },
  { :variable_name => 'EGREFID', :number => '11', :completion_instructions => 'Record the identifier number assigned.', :sponsor_info => 'This can be used to confirm that the
appropriate data record is present in the electronic transfer if this reference ID
happens to be available to the site at the time of collection. It can also be used to link the clinical significance assessment to the proper record in the electronic data.
(e.g., UUID for external waveform file, session number automatically generated
by electronic equipment).', :sdtm_category_id => '', :core => 'Optional', :definition => 'Internal or external identifier.', :data_collection_field => 'ECG Reference ID', :domain_id => '13' },
  { :variable_name => 'EXSTDAT', :number => '1', :completion_instructions => 'Record the exact date of the study treatment
administration using the CDASH- recommended date format (e.g., 08-AUG-
2008).  Best Practice
section.', :sponsor_info => 'Date when constant dosing interval of the
study treatment started or single administration occurred.
For the SDTM-based dataset, the SDTMIG variable EXSTDTC is derived by concatenating CDASH Start Date and Time of treatment (if time is collected) into EXSTDTC using the ISO 8601 format.', :sdtm_category_id => '', :core => 'Highly
Recommended', :definition => 'Start date of treatment.', :data_collection_field => 'Start Date', :domain_id => '14' },
  { :variable_name => 'EXSTTIM', :number => '2', :completion_instructions => 'Record the time (as complete as possible)
when administration of study treatment started.', :sponsor_info => 'Time when study treatment period started.
For the SDTM-based dataset, the SDTMIG variable EXSTDTC is derived by concatenating CDASH Start Date and Time of treatment (if time is collected) into EXSTDTC using the ISO 8601 format.', :sdtm_category_id => '', :core => 'Recommended /
Conditional', :definition => 'Start time of treatment. (Note: If collected, will be used to derive EXSTDTC.)', :data_collection_field => 'Start Time', :domain_id => '14' }
])
# BREAK EVAL
CdashQuestion.seed_many(:domain_id,:variable_name,[
  { :variable_name => 'EXENDAT', :number => '3', :completion_instructions => 'Record the end date or last date of
administration of study treatment using the
CDASH-recommended date format (e.g., 08- AUG-2008). .', :sponsor_info => 'Date when study treatment period
stopped.
If start date and end date are not expected to be on the same date, the end date is required. If the trial design indicates that the start and end date are on the same day, the end date is not required since it can be assigned to be equal to the start date.
For the SDTM-based dataset, the SDTMIG variable EXENDTC is derived by concatenating CDASH End Date and Time of treatment (if time is collected) into EXENDTC using the ISO 8601 format.', :sdtm_category_id => '', :core => 'Recommended /
Conditional', :definition => 'End date of treatment.', :data_collection_field => 'End Date', :domain_id => '14' },
  { :variable_name => 'EXENTIM', :number => '4', :completion_instructions => 'Record the time, (as complete as possible)
when study treatment administration stopped (e.g., for infusions this is the time when the infusion ended).
.', :sponsor_info => 'Time when study treatment “constant
dosing interval” ended.
For the SDTM-based dataset, the SDTMIG variable EXENDTC is derived by concatenating CDASH End Date and Time of treatment (if time is collected) into EXENDTC using the ISO 8601 format.', :sdtm_category_id => '', :core => 'Recommended /
Conditional', :definition => 'End time of treatment. (Note: If collected,
will be used to derive EXENDTC.)', :data_collection_field => 'End Time', :domain_id => '14' },
  { :variable_name => 'EXDOSE', :number => '5', :completion_instructions => 'Record the dose or amount of study treatment that was administered to/taken by the subject in the period recorded; from the start
date/time to the end date/time inclusive.', :sponsor_info => 'Dose or amount taken for single
administration of study treatment or per constant dosing interval recorded.
Dose must be collected if it cannot be derived via other methods (e.g., derived from randomization data).', :sdtm_category_id => '', :core => 'Recommended /
Conditional', :definition => 'Dose per administration.', :data_collection_field => 'Dose Amount', :domain_id => '14' },
  { :variable_name => 'EXLOT', :number => '7', :completion_instructions => 'Record the reference number that appears on
the container holding the study treatment
(e.g., Lot Number).', :sponsor_info => 'Reference number that appears on the
container holding the study treatment.
Study Treatment Identification Number is a unique number, which provides
mapping to Lot Number and possibly the randomization schema.
In open label studies, the reference number on the study treatment container could represent an actual Lot Number and should be stored using EXLOT.', :sdtm_category_id => '', :core => 'Optional', :definition => 'EXLOT = Lot Number of the EXTRT
product.', :data_collection_field => 'Study Treatment
Identification Number', :domain_id => '14' },
  { :variable_name => 'EXTRT', :number => '8', :completion_instructions => 'Record the name of study treatment.', :sponsor_info => 'Name of study treatment that was
administered to the subject.
This must be collected if it cannot be derived.
Variable must always be present in the underlying database, however, it may not be populated until after unblinding.', :sdtm_category_id => '', :core => 'Recommended /
Conditional', :definition => 'Name of the intervention treatment -
usually the verbatim name of the study treatment given per single administration
or during the “constant dosing interval”
for the observation.', :data_collection_field => 'Study Treatment
Name', :domain_id => '14' },
  { :variable_name => 'EXDOSADJ', :number => '9', :completion_instructions => 'Select either “Yes” or “No” to indicate
whether there was a change in dosing.', :sponsor_info => 'Will provide a definitive response
regarding dose changes.', :sdtm_category_id => '', :core => 'Optional', :definition => 'Confirmation of dose adjustment.', :data_collection_field => 'Dose Adjusted?', :domain_id => '14' },
  { :variable_name => 'EXADJ', :number => '10', :completion_instructions => 'If there was a change in dosing, record the
reason for change.', :sponsor_info => 'Captures reason dose was changed /
modified. The reason may be chosen from a select list or entered as free text. The list could include the values: escalated, decrease, delay or interrupted.', :sdtm_category_id => '', :core => 'Optional', :definition => 'Describes reason or explanation of why
a dose is adjusted – used only when an adjustment is represented in EXPOSURE dataset. May be used for
variations from protocol-specified doses, or changes from expected doses.', :data_collection_field => 'Reason for Dose
Adjustment', :domain_id => '14' },
  { :variable_name => 'EXINTP', :number => '14', :completion_instructions => 'Record the duration of treatment interruption.', :sponsor_info => 'Duration of treatment interruption.
In some situations, the duration of the
interruption may be calculated from the
administration start and end times
recorded elsewhere in the CRF.', :sdtm_category_id => '', :core => 'Optional', :definition => 'Duration of the treatment interruption.', :data_collection_field => 'Duration of
Interruption', :domain_id => '14' },
  { :variable_name => 'EXVOLT', :number => '16', :completion_instructions => 'Record the total volume that was administered/given to the subject.', :sponsor_info => 'Administration volume that was given to the subject.', :sdtm_category_id => '', :core => 'Optional', :definition => 'Exposure volume amount.', :data_collection_field => 'Total Volume Administered', :domain_id => '14' },
  { :variable_name => 'EXFLRT', :number => '18', :completion_instructions => 'Record the Rate of Infusion (e.g., 10 mL/min.
Record “10”as the infusion rate).', :sponsor_info => 'Infusion rate can be used to derive dose.', :sdtm_category_id => '', :core => 'Optional', :definition => 'Rate of infusion.', :data_collection_field => 'Flow Rate', :domain_id => '14' },
  { :variable_name => 'EXTPT', :number => '20', :completion_instructions => 'Record the planned time point of study treatment administration (e.g., 5 minutes post
Dose).', :sponsor_info => 'Indicates the planned time point of study treatment administration (e.g., 5 minutes
post dose).', :sdtm_category_id => '', :core => 'Optional', :definition => 'Planned time point name.', :data_collection_field => 'Planned Time Point', :domain_id => '14' },
  { :variable_name => 'EXMEDCMP', :number => '21', :completion_instructions => 'Select either “Yes” or “No” to indicate whether subject has completed the full course of treatment.', :sponsor_info => 'Depending on how the study treatment details are collected via the CRF/ eCRF, it may be possible to derive those data.', :sdtm_category_id => '', :core => 'Optional', :definition => 'Confirmation point for exposure.', :data_collection_field => 'Did subject complete full course of study Med?', :domain_id => '14' },
  { :variable_name => 'EXPDOSE', :number => '22', :completion_instructions => 'Record the dose the subject was scheduled to receive.', :sponsor_info => 'Important note:  This field must be used in conjunction with “actual dose” EXDOSE since this field captures the planned dose rather than the dose the subject actually received.', :sdtm_category_id => '', :core => 'Optional', :definition => 'Planned dose per administration.', :data_collection_field => 'Planned Dose', :domain_id => '14' },
  { :variable_name => 'IETESTCD', :number => '2', :completion_instructions => 'If “No”, enter the identifying code for each
criterion not met. Record this only for the criterion / criteria that this subject did not meet5.
Paper: Record the criterion identifier from the list of inclusion/ exclusion criteria provided by the sponsor.
EDC: Select the criterion from the pick-list.', :sponsor_info => 'This field is required to appear on the
CRF, but may be null if all criteria are met.
Multiple responses should be allowed on
CRF.
CDASH recommends that the sponsor determine how many lines are needed on the CRF based on their experience and maximum allowed. This would probably be only 2 or 3 for most studies.', :sdtm_category_id => '', :core => 'Highly
Recommended', :definition => 'The identifier associated with the
criterion that the subject did not meet. This must be a unique identifier that
corresponds to a specific entry criterion4.', :data_collection_field => 'Criterion Identifier3', :domain_id => '16' },
  { :variable_name => 'IETEST', :number => '3', :completion_instructions => 'EDC: Verify the wording of this criterion.', :sponsor_info => 'EDC: The primary use of this field would
be on an eCRF in an EDC system. This field could be automatically populated
when the Criterion Identifier is populated, and then be verified by the PI to ensure the
right Identifier was selected.
Paper: The monitoring process should include a cross-verification of entry criteria against the medical records for each subject to ensure that any criteria not met were recorded on the CRF.', :sdtm_category_id => '', :core => 'Optional', :definition => 'The wording of an inclusion or
exclusion criterion.', :data_collection_field => 'Criterion', :domain_id => '16' },
  { :variable_name => 'IECAT', :number => '4', :completion_instructions => 'Record whether the criterion that this subject
did not meet was “Inclusion” or “Exclusion”.
Checkbox: Check “Inclusion” or
“Exclusion”.', :sponsor_info => 'Only records for criteria that are not met
appear in the IE SDTMIG domain and for those records IECAT must also be
populated.
This criterion category may be collected on the CRF in a checkbox format, or, it may be included as part of the Criterion Identifier (e.g., I01, E01), or derived from the inclusion / exclusion criteria in the Trial Inclusion (TI) trial dataset, or other protocol definitions external to the clinical database when a unique criterion identifier is recorded in the IETESTCD field.', :sdtm_category_id => '', :core => 'Optional', :definition => 'Specifies whether the criterion is
inclusion or exclusion.', :data_collection_field => 'Inclusion or
Exclusion?', :domain_id => '16' },
  { :variable_name => 'LBPERF', :number => '1', :completion_instructions => 'Indicate whether or not lab sample was
collected or measurement performed.', :sponsor_info => 'This may be implemented for an entire
panel, or on a test-by-test basis. This is intended to be used as a data management tool to verify that missing results are confirmed missing.', :sdtm_category_id => '', :core => 'Highly
Recommended', :definition => 'Status of whether or not lab sample was
collected or measurement performed.', :data_collection_field => 'Lab Status', :domain_id => '18' },
  { :variable_name => 'LBDAT', :number => '2', :completion_instructions => 'Record the date when sample collection
occurred using the CDASH-recommended date format (e.g., 08-AUG-2008).
For more details see Best Practice
Recommendations.', :sponsor_info => 'A complete date is expected.
The date of collection may be derived from the date of visit and if so, a separate assessment date field is not required.
For the SDTM-based dataset, the SDTMIG variable LBDTC is derived by concatenating CDASH Date and Time of collection (if time is collected) into LBDTC using the ISO 8601 format.', :sdtm_category_id => '', :core => 'Highly
Recommended', :definition => 'Date of sample collection.', :data_collection_field => 'Date of Collection', :domain_id => '18' },
  { :variable_name => 'LBTIM', :number => '3', :completion_instructions => 'Record time of collection (as complete as
possible).
For more details see Best Practice
Recommendations.', :sponsor_info => 'Especially important when multiple
assessments are done on one day.
For the SDTM-based dataset, the SDTMIG variable LBDTC is derived by concatenating CDASH Date and Time of collection (if time is collected) into LBDTC using the ISO 8601 format.', :sdtm_category_id => '', :core => 'Recommended/
Conditional', :definition => 'Time of sample collection. (Note: If collected,
will be used to derive LBDTC.)', :data_collection_field => 'Time of Collection', :domain_id => '18' },
  { :variable_name => 'LBCAT
LBSCAT', :number => '4', :completion_instructions => 'Record the lab test category, if not pre-
printed on the CRF.', :sponsor_info => 'Included as needed for clarity (e.g.,
HEMATOLOGY, URINALYSIS, CHEMISTRY).', :sdtm_category_id => '', :core => 'Recommended/
Conditional', :definition => 'Type of draw / category / panel name.
Used to define a category of related records.', :data_collection_field => 'Panel Name', :domain_id => '18' },
  { :variable_name => 'LBTPT', :number => '5', :completion_instructions => 'Record the planned time point labels for the
lab test, if not pre-printed on the CRF.', :sponsor_info => 'Planned time point would be needed to
differentiate for multiple sequential assessments.
It is recommended that time points should be pre-printed on the CRF rather than collected in a field that requires the site to enter text.', :sdtm_category_id => '', :core => 'Recommended/
Conditional', :definition => 'Text description of planned time point
when measurements should be taken for use when multiple sequential
assessments are done.', :data_collection_field => 'Planned Time Point', :domain_id => '18' },
  { :variable_name => 'LBCOND', :number => '6', :completion_instructions => 'Record whether protocol defined testing
conditions were met.', :sponsor_info => 'The specific testing conditions required
should be pre-printed on the CRF, such as
“ Did subject meet fasting requirements?”. Results may be affected by whether
conditions for testing were properly met
(e.g., fasting).
This may not be relevant for all tests.
For the SDTM-based dataset, the SDTMIG variable LBFAST could be derived from LBCOND.', :sdtm_category_id => '', :core => 'Recommended/
Conditional', :definition => 'Condition imposed on the subject for
testing defined in the protocol (e.g., fasting).', :data_collection_field => 'Protocol-defined
testing conditions met', :domain_id => '18' },
  { :variable_name => 'LBSPCCND', :number => '7', :completion_instructions => 'Record condition of sample.', :sponsor_info => 'Results may be affected by whether
conditions for sample were properly met
(e.g., HEMOLYZED, ICTERIC, LIPEMIC)', :sdtm_category_id => '', :core => 'Recommended/
Conditional', :definition => 'Free or standardized text describing the
condition of the specimen.', :data_collection_field => 'Sample Status', :domain_id => '18' },
  { :variable_name => 'LBORRES', :number => '9', :completion_instructions => 'Record test results.', :sponsor_info => 'Key data collected.', :sdtm_category_id => '', :core => 'Highly
Recommended', :definition => 'Result of the measurement or finding
as originally received or collected.', :data_collection_field => 'Test Result', :domain_id => '18' },
  { :variable_name => 'LBORRESU', :number => '10', :completion_instructions => 'Record the units of the lab test, if not pre-
printed on the CRF or captured in an external “lab normal” file.', :sponsor_info => 'May be included if not standardized.', :sdtm_category_id => '', :core => 'Highly
Recommended', :definition => 'Original units in which the data were
collected.', :data_collection_field => 'Units', :domain_id => '18' },
  { :variable_name => 'LBORNRLO', :number => '11', :completion_instructions => 'Record the lower limit of the reference
range of the lab test.', :sponsor_info => 'LBORNRLO and LBORNRHI should be
populated only for continuous results; LBSTNRC should be populated only for
 non-continuous results. These data may
be obtained from the lab or the electronic equipment.
These data could be derived from a site
or lab specific set of normal ranges stored in a look up table.
NOTE: See SDTMIG for details on mapping on selecting the proper variable name.', :sdtm_category_id => '', :core => 'Recommended/
Conditional', :definition => 'The lowest continuous numeric value
of a given lab result expected in the population of interest.
See SDTMIG for additional information.', :data_collection_field => 'Reference Range
Lower Limit
Numeric Value', :domain_id => '18' },
  { :variable_name => 'LBORNRHI', :number => '12', :completion_instructions => 'Record the upper limit of the reference
range of the lab test.', :sponsor_info => '', :sdtm_category_id => '', :core => 'Recommended/
Conditional', :definition => 'The highest continuous numeric value
of a given lab result expected in the population of interest.
See SDTMIG for additional information.', :data_collection_field => 'Reference Range
Upper Limit Numeric
Value', :domain_id => '18' },
  { :variable_name => 'LBSTNRC', :number => '13', :completion_instructions => 'Record the boundaries of reference ranges
of the lab test.', :sponsor_info => '', :sdtm_category_id => '', :core => 'Recommended/
Conditional', :definition => 'The set of categorical lab values
expected in the population of interest. See SDTMIG for additional
information.', :data_collection_field => 'Reference Range for
Character Results in
Standard Units', :domain_id => '18' },
  { :variable_name => 'LBNRIND', :number => '14', :completion_instructions => 'Record whether sample was outside range.', :sponsor_info => 'Abnormal flags may be included if not
derived or determined programmatically after data collection.', :sdtm_category_id => '', :core => 'Recommended/
Conditional', :definition => 'Reference Range Indicator Indicates
where value falls with respect to reference range defined by high and low ranges.', :data_collection_field => 'Abnormal Flag', :domain_id => '18' },
  { :variable_name => 'LBCLSIG', :number => '15', :completion_instructions => 'Record whether lab results were clinically
significant.', :sponsor_info => 'May be included if required by the
 protocol.', :sdtm_category_id => '', :core => 'Recommended/
Conditional', :definition => 'Whether lab test results were clinically
significant.', :data_collection_field => 'Clinical Significance', :domain_id => '18' },
  { :variable_name => 'LBNAM', :number => '16', :completion_instructions => 'Record the laboratory name.', :sponsor_info => 'May be included on CRF if multiple labs
are used by a site.
If collecting lab names as free text, sponsors might consider developing a LAB ID so that different ways of writing the names of certain labs will not appear in datasets as different labs.', :sdtm_category_id => '', :core => 'Recommended/
Conditional', :definition => 'Name of lab analyzing sample.', :data_collection_field => 'Lab Name', :domain_id => '18' },
  { :variable_name => 'LBREFID', :number => '17', :completion_instructions => 'Record the sample or accession number
assigned.', :sponsor_info => 'This can be used to confirm that the
appropriate data record is present in the electronic transfer
May be included for linking back to samples (e.g., Specimen ID).', :sdtm_category_id => '', :core => 'Recommended/
Conditional', :definition => 'Internal or external specimen
identifier.', :data_collection_field => 'Accession Number', :domain_id => '18' },
  { :variable_name => 'MHSPID', :number => '2', :completion_instructions => 'Not applicable.', :sponsor_info => 'Some sponsors may pre-number the rows
used to capture the data. If these
identifiers are submitted, MHSPID should be used.', :sdtm_category_id => '', :core => 'Optional', :definition => 'Optional sponsor-defined reference
number (e.g., pre-printed line number).', :data_collection_field => 'Pre-printed row
number (e.g., 1, 2, 3)', :domain_id => '20' },
  { :variable_name => 'MHCAT', :number => '3', :completion_instructions => 'Not applicable.', :sponsor_info => 'The sponsor may or may not pre-print on
the CRF the type of medical history being captured. If specific medical
 history (e.g., disease diagnosis) is
captured in addition to the general medical history, it may be helpful to pre- print the history type on the CRF. Regardless, MHCAT may be populated in the database as derived field.
Note: MHCAT must be in the database if
MHSCAT is used.', :sdtm_category_id => '', :core => 'Recommended/
Conditional', :definition => 'Used to define a category of related
records (e.g., CARDIAC or
GENERAL).', :data_collection_field => 'Type of Medical
History being collected', :domain_id => '20' },
  { :variable_name => 'MHSCAT', :number => '4', :completion_instructions => 'Note: The CRF instructions will depend
upon the format of the CRF. Some sponsors ask the sites to use a numeric code (e.g., “123”) to designate a particular category (e.g., “cardiovascular”) while other sponsors will simply pre-print the
categories on the CRF and provide space for the site to record the ailment, disease or
surgery.
Instruction examples:
Use the (sponsor-defined) code list to group the past and / or concomitant medical conditions or surgeries. For example, if the subject has a history of high blood pressure, use code “123” for “cardiovascular”.
OR
Record the concomitant medical conditions or past surgeries under the appropriate category. For example, “high blood pressure” should be recorded under “cardiovascular”.', :sponsor_info => 'The pre-printed groupings should be used
if the sponsor will not code medical history. The categories should be sponsor-defined as sponsors may have
different needs. (Code “123” used in the instructions is simply an example.) The MedDRA SOCs should not be used as
categories on the CRF for several reasons. Sites are probably not familiar with the SOCs. It would be cumbersome to include the 26 organ classes on the
CRF, entry screen or completion instructions. The reviewers expect this
information to be stored in MHBODSYS. Finally, the sponsor may only wish to
inquire about particular groupings or specific diseases; not actual body
systems.
Note that “123” would not be stored in MHSCAT. In this example, “cardiovascular” is the MHSCAT. Numeric codes used on the CRF as an operational tactic to facilitate data entry must be removed prior to submission as they provide no meaning to the reviewer.
Also Note that MHCAT must be in the database if MHSCAT is used.', :sdtm_category_id => '', :core => 'Recommended/
Conditional', :definition => 'A categorization of the condition or
event pre-printed on the CRF or instructions.', :data_collection_field => 'Category of Medical
History being collected', :domain_id => '20' },
  { :variable_name => 'MHTERM', :number => '5', :completion_instructions => 'Record all relevant past and / or
concomitant medical conditions and past
surgeries, as defined in the protocol. Record
only one condition or surgery per line.
When recording a condition and surgery
related to that condition, use one line for the
condition and one line for the surgery.
Ensure that any of the conditions listed on
the Medical History page do not meet any
of the exclusion criteria.', :sponsor_info => 'Note that if sponsors need to capture
more detailed surgery information (e.g.,
VNS implantation for Epilepsy trials), an
additional CRF module should be used,
modeled as an Interventions domain.', :sdtm_category_id => '', :core => 'Highly Recommended', :definition => 'Verbatim or preprinted CRF term for the medical condition or event.', :data_collection_field => 'Reported Term', :domain_id => '20' },
  { :variable_name => 'MHONGO', :number => '6', :completion_instructions => 'Select the most appropriate response.', :sponsor_info => 'Note that MHONGO is not defined in the
SDTMIG MH domain. If collected, it should be used to derive MHENRTPT.
The Visit Date, captured in the header, or
MHDAT, should be used as the reference time point (MHENTPT).', :sdtm_category_id => '', :core => 'Optional', :definition => 'Identifies the end of the event as being
ONGOING.', :data_collection_field => 'Ongoing?', :domain_id => '20' },
  { :variable_name => 'MHCTRL', :number => '7', :completion_instructions => 'Select the most appropriate response.', :sponsor_info => 'Note that MHONGO is not defined in the
SDTMIG MH domain. If collected, it should be used to derive MHENRTPT. The Visit Date, captured in the header, or MHDAT, should be used as the reference time point (MHENTPT).', :sdtm_category_id => '', :core => 'Optional', :definition => 'Identifies the end of the event as being
ONGOING.', :data_collection_field => 'Disease controlled?', :domain_id => '20' },
  { :variable_name => 'MHOCCUR', :number => '8', :completion_instructions => 'Please indicate if “xyz” has occurred by
checking “Yes” or “No”.', :sponsor_info => 'MHOCCUR should only be used if the
condition pre-printed on the CRF elicits a “Yes” or “No” response. MHOCCUR should not be used if the conditions are collected on the CRF in a manner that requires a free-flow text response.', :sdtm_category_id => '', :core => 'Optional', :definition => 'A pre-printed prompt used to indicate
whether or not a medical condition has occurred.', :data_collection_field => 'Pre-printed prompt
for a specific condition/surgery (e.g., Does the subject have high blood pressure?)', :domain_id => '20' },
  { :variable_name => 'MHSTDAT', :number => '9', :completion_instructions => 'Record the onset date using the CDASH-
recommended date format (e.g., 22-AUG-
2008). For more details see Best Practice
Recommendations.', :sponsor_info => 'The sponsor may choose to capture a
 complete date or any variation thereof
(e.g., month & year or year, etc.).
For the SDTM-based dataset, the SDTMIG variable MHSTDTC is derived from the CDASH Onset Date using the ISO 8601 format.', :sdtm_category_id => '', :core => 'Optional', :definition => 'Start date of Medical History event.', :data_collection_field => 'Onset Date', :domain_id => '20' },
  { :variable_name => 'MHDAT', :number => '10', :completion_instructions => 'Record the end date using the CDASH-
 recommended date format (e.g., 22-AUG-
2008). For more details see Best Practice
Recommendations.', :sponsor_info => 'The sponsor may choose to capture a
 complete date or any variation thereof
(month & year or year, etc.).
For the SDTM-based dataset, the SDTMIG variable MHENDTC is derived from the CDASH End Date using the
ISO 8601 format.', :sdtm_category_id => '', :core => 'Optional', :definition => 'End date of Medical History event.', :data_collection_field => 'End Date', :domain_id => '20' },
  { :variable_name => 'MHDAT', :number => '11', :completion_instructions => 'Record the date on which the Medical
History was taken using the CDASH- recommended date format (e.g., 22-AUG-
2008). For more details see Best Practice
Recommendations.', :sponsor_info => 'This should be a complete date.', :sdtm_category_id => '', :core => 'Optional', :definition => 'Completion date of the Medical
History data collection form.', :data_collection_field => 'Completion Date', :domain_id => '20' },
  { :variable_name => 'PEDAT', :number => '2', :completion_instructions => 'Record complete date of examination, day,
month and year using the CDASH- recommended date format (e.g., 08-AUG-
2008).  Best Practice
section.', :sponsor_info => 'The date of examination may be derived
from the date of visit and therefore a separate assessment date field is not
required.
For the SDTM-based dataset, the SDTMIG variable PEDTC is derived by concatenating CDASH Date and Time of Examination (if time is collected) into PEDTC using the ISO 8601 format.', :sdtm_category_id => '', :core => 'Recommended/
Conditional', :definition => 'Date of examination.', :data_collection_field => 'Date of Examination', :domain_id => '25' },
  { :variable_name => 'PETIM', :number => '3', :completion_instructions => 'Record the time of examination (as complete
as possible).  Best
Practice section.', :sponsor_info => 'For the SDTM-based dataset, the
SDTMIG variable PEDTC is derived by concatenating CDASH Date and Time of Examination (if time is collected) into PEDTC using the ISO 8601 format.', :sdtm_category_id => '', :core => 'Optional', :definition => 'Time of examination. (Note: If collected,
will be used to derive PEDTC.)', :data_collection_field => 'Time of Examination', :domain_id => '25' },
  { :variable_name => 'PESPID', :number => '4', :completion_instructions => 'Not applicable.', :sponsor_info => 'May be pre-printed on the CRF as an
explicit line identifier or defined in the sponsor’s operational database.', :sdtm_category_id => '', :core => 'Optional', :definition => 'Sponsor-defined reference number.', :data_collection_field => 'Sponsor-Defined
Identifier', :domain_id => '25' },
  { :variable_name => 'PETEST', :number => '5', :completion_instructions => 'Per protocol, perform physical examinations
of specified body systems.', :sponsor_info => 'Sponsor should pre-populate CRF with all
body systems to be examined. The use of a complete list of body systems eliminates
the need for an other/specify category as
any abnormalities identified should fall under one of the pre-specified categories.
Even if the sponsor does not require all body systems to be examined at a given time point, the complete list should still be used. Instructions should be given to the site to record “Not Done” in Exam Result field for any systems not examined.', :sdtm_category_id => '', :core => 'Highly
Recommended', :definition => 'Name of the body system.', :data_collection_field => 'Body System
Examined', :domain_id => '25' },
  { :variable_name => 'PERES', :number => '6', :completion_instructions => 'For each body system listed, record the result
of the examination (Normal or Abnormal). If the examination is not performed or not
required select Not Done.', :sponsor_info => 'For each body system listed on the CRF,
provide the following options for results: Normal, Abnormal and Not Done. Sites
should be directed to complete overall
assessment for each exam category/body system listed.
In SDTMIG, if the examined body system is normal then the value in PEORRES should be NORMAL. If the body system is not examined, then the value in PEORRES should be Null and the value in PESTAT should be Not Done. If the examined body system is abnormal, then the value of PEORRES should contain the text of the abnormal findings.
If the sponsor’s data collection system allows for up front recording of the abnormality and status using one variable then the SDTMIG variable name PEORRES should be used in place of CDASH variable names PERES and PEDESC', :sdtm_category_id => '', :core => 'Highly
Recommended', :definition => 'Overall assessment of examined body
system.', :data_collection_field => 'Examination Result', :domain_id => '25' },
  { :variable_name => 'PEDESC', :number => '7', :completion_instructions => 'Record all abnormal findings for the given
body system in the space provided.', :sponsor_info => 'Text entered under abnormal findings
(PEDESC) should be mapped to
PEORRES.
If the sponsor’s data collection system allows for up front recording of the abnormality and status using one variable then the SDTMIG variable name PEORRES should be used in place of CDASH variable names PERES and PEDESC', :sdtm_category_id => '', :core => 'Highly
Recommended', :definition => 'Text description of any abnormal
findings.', :data_collection_field => 'Abnormal Findings', :domain_id => '25' },
  { :variable_name => 'PECLSIG', :number => '8', :completion_instructions => 'Record whether abnormality is clinically
significant.', :sponsor_info => 'If this level of information is needed for
reconciliation with adverse events, this field may be added to the CRF.', :sdtm_category_id => '', :core => 'Optional', :definition => 'Whether physical examination
abnormality is clinically significant', :data_collection_field => 'Clinical Significance', :domain_id => '25' },
  { :variable_name => 'PEEVAL', :number => '9', :completion_instructions => 'Enter the role of the person who provided the
evaluation (e.g., investigator, adjudication committee, vendor).', :sponsor_info => 'Used only for results that are subjective.
Should be null for records that contain collected or derived data.', :sdtm_category_id => '', :core => 'Optional', :definition => 'Role of the person who provided the
evaluation.', :data_collection_field => 'Evaluator', :domain_id => '25' },
  { :variable_name => 'DVTERM
And/or
DVDECOD', :number => '2', :completion_instructions => 'Record protocol deviation identified and/or
select the appropriate code from the list of protocol deviation terms.', :sponsor_info => 'This may be derived. Only “Highly
Recommended” if collecting protocol deviations on a CRF.', :sdtm_category_id => '', :core => 'Highly
Recommended', :definition => 'Verbatim text of the variation from
processes or procedures defined in a protocol and/or controlled terminology for the name of the protocol deviation.', :data_collection_field => 'Protocol Deviation
Term (text) and or Protocol Deviation Coded Term', :domain_id => '11' },
  { :variable_name => 'DVSTDAT', :number => '3', :completion_instructions => 'Record complete date that the protocol
deviation began using the CDASH- recommended date format (e.g., 08-AUG-
2008). For more detail instructions see the

This should be the start or occurrence of the protocol deviation and not the date it was discovered or reported.', :sponsor_info => 'This may be derived if not collected on a
CRF.
For the SDTM-based dataset, the SDTMIG variable DVSTDTC is derived by concatenating CDASH Start Date and Time (if time is collected) into DVSTDTC using the ISO 8601 format.', :sdtm_category_id => '', :core => 'Optional', :definition => 'Start date of Deviation.', :data_collection_field => 'Start Date', :domain_id => '11' },
  { :variable_name => 'DVSTTIM', :number => '4', :completion_instructions => 'If appropriate, record the time (as complete
as possible) the protocol deviation began. For more detail instructions see the Best
Practice section.
This should be the start or occurrence of the protocol deviation and not the time it was discovered or reported.', :sponsor_info => 'For the SDTM-based dataset, the SDTMIG variable DVSTDTC is derived by concatenating CDASH Start Date and Time (if time is collected) into DVSTDTC using the ISO 8601 format.', :sdtm_category_id => '', :core => 'Optional', :definition => 'Start time of Deviation.  (Note: If collected, will be derived into DVSTDTC.)', :data_collection_field => 'Start Time', :domain_id => '11' },
  { :variable_name => 'DVENDAT', :number => '5', :completion_instructions => 'Record the date that the Protocol deviation
ended using the CDASH-recommended date format (e.g., 08-AUG-2008). .
This should be the date the protocol deviation stopped and not the date it was discovered or reported.', :sponsor_info => 'For the SDTM-based dataset, the SDTMIG variable DVENDTC is derived by concatenating CDASH End Date and Time (if time is collected) into DVENDTC using the ISO 8601 format.', :sdtm_category_id => '', :core => 'Optional', :definition => 'End date of Deviation.', :data_collection_field => 'End Date', :domain_id => '11' },
  { :variable_name => 'DVENTIM', :number => '6', :completion_instructions => 'Optionally, if appropriate, record the time (as
complete as possible) the protocol deviation ended.
This should be the time the protocol deviation stopped and not the time it was discovered or reported.', :sponsor_info => 'For the SDTM-based dataset, the
SDTMIG variable DVENDTC is derived by concatenating CDASH End Date and Time (if time is collected) into DVENDTC using the ISO 8601 format.', :sdtm_category_id => '', :core => 'Optional', :definition => 'End time of Deviation. (Note: If collected,
will be derived into
DVENDTC.)', :data_collection_field => 'End Time', :domain_id => '11' },
  { :variable_name => 'DVSPID', :number => '7', :completion_instructions => 'Not applicable.', :sponsor_info => 'Can be pre-printed on the CRF as an
explicit line identifier or defined in sponsor’s operational database (e.g., Line
number on a CRF page).', :sdtm_category_id => '', :core => 'Optional', :definition => 'Sponsor-defined reference number.', :data_collection_field => 'Sponsor-Defined
Identifier', :domain_id => '11' },
  { :variable_name => 'SCORRES', :number => '2', :completion_instructions => 'Record the answer to the question.', :sponsor_info => 'Not applicable.', :sdtm_category_id => '', :core => 'Highly
Recommended', :definition => 'Answer/result of the subject
characteristic question as originally received or collected.', :data_collection_field => 'Subject Characteristic
Answer/Result', :domain_id => '29' },
  { :variable_name => 'SCTEST', :number => '1', :completion_instructions => 'Not applicable.', :sponsor_info => 'A constant that may be useful for analysis in pediatric or
neonatal study analyses.', :sdtm_category_id => '', :core => '', :definition => 'The age (in weeks) of the newborn
infant, counted from the woman\'s last menstrual period (LMP) or health status
indicators / Clinical Estimate (CE).', :data_collection_field => 'Gestational Age at
Birth', :domain_id => '29' },
  { :variable_name => 'SCTEST', :number => '2', :completion_instructions => 'Check the correct box to indicate the
subject’s childbearing potential, or postmenopausal or sterilized as required for
the form.', :sponsor_info => 'Not applicable.', :sdtm_category_id => '', :core => '', :definition => 'Subject’s childbearing potential.', :data_collection_field => 'Childbearing Potential', :domain_id => '29' },
  { :variable_name => 'SCTEST', :number => '3', :completion_instructions => 'Not applicable.', :sponsor_info => 'Not applicable.', :sdtm_category_id => '', :core => '', :definition => 'Education level achieved at start of
study (Reference date).', :data_collection_field => 'Education', :domain_id => '29' },
  { :variable_name => 'SCTEST', :number => '4', :completion_instructions => 'Not applicable.', :sponsor_info => 'For some studies sub-study information is captured, such as
“subject is on fasting sub-study” or “subject is on PK sub- study”.', :sdtm_category_id => '', :core => '', :definition => 'Sub-study participation information.', :data_collection_field => 'Sub-study
Participation', :domain_id => '29' },
  { :variable_name => 'SUTRT', :number => '1', :completion_instructions => 'Not applicable.', :sponsor_info => 'Note that sponsors may require different
types of substance use data (e.g., illicit drug use, cigarettes, etc.); the value for category may be pre-printed on the CRF
as a label for the prompt for Substance
Use.
If a more detailed type of substance appears on the CRF (e.g., cigarettes, cigars, rather than tobacco), SUCAT should be “tobacco” and SUTRT should be “cigarettes”. If the sponsor does not specify a type of tobacco on the CRF, SUTRT should be “tobacco”.', :sdtm_category_id => '', :core => 'Highly
Recommended', :definition => 'The type of substance (e.g., TOBACCO,
ALCOHOL, CAFFEINE, etc. Or CIGARETTES, CIGARS, COFFEE, etc.).', :data_collection_field => 'Type of substance
 used?', :domain_id => '36' },
  { :variable_name => 'SUNCF', :number => '2', :completion_instructions => 'Check the appropriate box to indicate if the
subject has ever used/consumed tobacco /
alcohol / caffeine, currently consumes tobacco / alcohol / caffeine, or formerly used/consumed tobacco / alcohol / caffeine.', :sponsor_info => 'The Domain Team recommends the use
of “NEVER”, “CURRENT” and
“FORMER” as responses.
The three options, “NEVER”, “CURRENT” and “FORMER” should be sponsor-defined. If the sponsor has specific definitions for the three, these definitions should be detailed in the instructions to the site.
As this type of response does not easily correspond to an SDTMIG variable. The Domain Team recommends using SUNCF as the variable name in the clinical database. Note that SUNCF is not defined in the SDTM and, generally,
should be dropped prior to submission. If submitted, it should be stored in
SUPPSU.
Note that “NEVER” maps to SUOCCUR as “N”. “CURRENT” and “FORMER” map to SUOCCUR as “Y”.', :sdtm_category_id => '', :core => 'Highly
Recommended', :definition => 'Substance Use Occurrence', :data_collection_field => 'Substance use?', :domain_id => '36' },
  { :variable_name => 'SUCAT', :number => '3', :completion_instructions => 'Not applicable.', :sponsor_info => 'Note that sponsors may require different
types of substance use data (e.g., illicit drug use, cigarettes, etc.); the value for category may be pre-printed on the CRF as a label for the Prompt for Substance Use.
If a more detailed type of substance appears on the CRF (e.g., cigarettes, cigars, rather than tobacco), SUCAT should be “tobacco” and SUTRT should be “cigarettes”. If the sponsor does not specify a type of tobacco on the CRF, SUTRT should be “tobacco”.', :sdtm_category_id => '', :core => 'Optional', :definition => 'Used to define a category of related
records (e.g., TOBACCO, ALCOHOL, CAFFEINE, etc.).', :data_collection_field => 'Category of substance
 used', :domain_id => '36' },
  { :variable_name => 'SUDOSTXT', :number => '4', :completion_instructions => 'Check the appropriate box to indicate the
amount of tobacco / alcohol / caffeine the subject consumes on a regular basis.', :sponsor_info => 'Where possible, the options for dose/amount should be pre-printed on the CRF.
Note that in the example given in the Definition, “(packs)” and “(ounces)” have been included as a point of reference. They would, of course, be stored as SUDOSU.
If the dose is part of a planned analysis, then the use of SUDOSE, a numeric field, should be considered.', :sdtm_category_id => '', :core => 'Optional', :definition => 'Substance use consumption amounts or
a range of consumption information collected in text form [e.g., 1-2
(packs), 8 (ounces), etc].', :data_collection_field => 'Amount', :domain_id => '36' },
  { :variable_name => 'SUDOSU', :number => '5', :completion_instructions => 'Not applicable.', :sponsor_info => 'Where possible, the options for dose/amount units should be pre-printed on the CRF.', :sdtm_category_id => '', :core => 'Optional', :definition => 'Units for SUDOSTXT (e.g., PACKS,
OUNCES, etc.).', :data_collection_field => 'Unit', :domain_id => '36' },
  { :variable_name => 'SUDOSFRQ', :number => '6', :completion_instructions => 'Not applicable.', :sponsor_info => 'Where possible, the options for
dose/amount frequency should be pre- printed on the CRF.', :sdtm_category_id => '', :core => 'Optional', :definition => 'Usually expressed as the number of uses
consumed per a specific interval (e.g., PER DAY, PER WEEK,
OCCASIONAL).', :data_collection_field => 'Frequency', :domain_id => '36' },
  { :variable_name => 'SUSTDAT', :number => '7', :completion_instructions => 'Record the start date using the CDASH-
 recommended date format (e.g., 22-AUG-
2008). For more details see Best Practice
Recommendations.', :sponsor_info => 'The sponsor may choose to capture a
complete date or any variation thereof
(e.g., month & year or year, etc.).', :sdtm_category_id => '', :core => 'Optional', :definition => 'Date substance use started.', :data_collection_field => 'Start Date', :domain_id => '36' },
  { :variable_name => 'SUENDAT', :number => '8', :completion_instructions => 'Record the end date using the CDASH-
recommended date format (e.g., 22-AUG-
2008). For more details see Best Practice
Recommendations.', :sponsor_info => 'The sponsor may choose to capture a
complete date or any variation thereof
(e.g., month & year or year, etc.).', :sdtm_category_id => '', :core => 'Optional', :definition => 'Date substance use ended.', :data_collection_field => 'End Date', :domain_id => '36' },
  { :variable_name => 'SUCDUR', :number => '9', :completion_instructions => 'Provide the duration of the Substance
Abuse (e.g., Record how long the subject has smoked).', :sponsor_info => 'This should only be collected on the CRF
 if this level of detail is needed and if
SUSTDTC & SUENDTC are not
collected on the CRF.
The sponsor-defined options (e.g., weeks, months, years, etc.) should be pre-printed on the CRF to avoid making this a free text field. This will allow the response to be translated into ISO 8601 format.
For the SDTM-based dataset, the SDTMIG variable SUDUR can be derived by concatenating the CDASH duration and duration units variables.', :sdtm_category_id => '', :core => 'Optional', :definition => 'The duration of the substance use.', :data_collection_field => 'Duration', :domain_id => '36' },
  { :variable_name => 'SUCDURU', :number => '10', :completion_instructions => 'Not applicable.', :sponsor_info => '', :sdtm_category_id => '', :core => 'Optional', :definition => 'Units for SUCDUR (e.g., weeks,
months, years, etc.).', :data_collection_field => 'Unit for Duration', :domain_id => '36' },
  { :variable_name => 'VSDAT', :number => '1', :completion_instructions => 'Record date of measurements using the
CDASH-recommended date format (e.g., 08- AUG-2008). For more detail instructions see the', :sponsor_info => 'The date of measurement can usually be
derived from the date of visit and in such cases a separate measurement date field is not required.
For the SDTM-based dataset, the SDTMIG variable VSDTC is derived by concatenating CDASH Date and Time of Vital Sign Measurements (if time is collected) into VSDTC using the ISO 8601 format.', :sdtm_category_id => '', :core => 'Recommended/
Conditional', :definition => 'Date of measurements', :data_collection_field => 'Date of Measurements', :domain_id => '43' },
  { :variable_name => 'VSTIM', :number => '2', :completion_instructions => 'Record time of measurement (as complete as
possible). For more detail instructions see the', :sponsor_info => 'For the SDTM-based dataset, the
SDTMIG variable VSDTC is derived by concatenating CDASH Date and Time of Vital Sign Measurements (if time is
collected) into VSDTC using the ISO 8601 format.', :sdtm_category_id => '', :core => 'Recommended/
Conditional', :definition => 'Time of measurements. (Note: If collected,
will be used to derive
VSDTC.)', :data_collection_field => 'Time of Vital Sign
Measurements', :domain_id => '43' },
  { :variable_name => 'VSSPID', :number => '3', :completion_instructions => 'Not applicable.', :sponsor_info => 'Pre-printed on the CRF as an explicit line
identifier or defined in the sponsor’s operational database.', :sdtm_category_id => '', :core => 'Optional', :definition => 'Sponsor-defined reference number', :data_collection_field => 'Sponsor-Defined
Identifier', :domain_id => '43' },
  { :variable_name => 'VSTPT', :number => '4', :completion_instructions => 'Not applicable.', :sponsor_info => 'If applicable, this will be pre-printed on
CRF when measurements are required at multiple time points within a visit day.', :sdtm_category_id => '', :core => 'Recommended/
Conditional', :definition => 'Text description of time when
measurement should be taken', :data_collection_field => 'Planned Time Point', :domain_id => '43' },
  { :variable_name => 'VSSTAT', :number => '6', :completion_instructions => 'If measurement not taken please indicate on
CRF by selecting Not Done.', :sponsor_info => 'If CRF design provides for individual status
check boxes where site can indicate Not
Done for the given parameter, information would be stored as Not Done in VSSTAT. If value exists in VSORRES then the result in VSSTAT is Null.
If CRF guidelines direct site to enter Not Done (or similar text) in the result field, then value of VSSTAT is Not Done, otherwise if numeric value exists in result variable (VSORRES) then value of VSSTAT is Null.
This field is used to assist in data monitoring and cleaning', :sdtm_category_id => '', :core => 'Recommended/
Conditional', :definition => 'Used to indicate that a vital signs
measurement was not done.', :data_collection_field => 'Vitals Status', :domain_id => '43' },
  { :variable_name => 'VSORRES', :number => '7', :completion_instructions => 'Record vital sign results.', :sponsor_info => 'Key data collected.', :sdtm_category_id => '', :core => 'Highly
Recommended', :definition => 'Result of the vital signs measurement as
originally received or collected.', :data_collection_field => 'Vital Sign Test Result
or Finding', :domain_id => '43' },
  { :variable_name => 'VSORRESU', :number => '8', :completion_instructions => 'Record or select the unit of measure
associated with the test, if not pre-printed on the CRF.', :sponsor_info => 'It is recommended that the units be
sponsor-defined and pre-printed on the
CRF when possible.', :sdtm_category_id => '', :core => 'Highly
Recommended', :definition => 'Original units in which the data were
collected.', :data_collection_field => 'Original Units', :domain_id => '43' },
  { :variable_name => 'VSCLSIG', :number => '9', :completion_instructions => 'Record whether vital sign result was clinically
significant.', :sponsor_info => 'If this level of information is needed, it
may be added to the CRF.', :sdtm_category_id => '', :core => 'Optional', :definition => 'Whether vital sign result was clinically
significant.', :data_collection_field => 'Clinical Significance', :domain_id => '43' },
  { :variable_name => 'STUDYID', :number => '1', :completion_instructions => 'Not applicable.', :sponsor_info => 'This is typically pre-printed/pre-
populated.', :sdtm_category_id => '', :core => 'Highly
Recommended', :definition => 'Unique Identifier for a study within
a submission.', :data_collection_field => 'Protocol/Study
Identifier', :domain_id => '39' },
  { :variable_name => 'SITEID
Or
SITENO', :number => '2', :completion_instructions => 'Record your clinical site’s identifier as
defined by the sponsor.', :sponsor_info => 'EDC: This should be pre-populated.
If SITEID is not used, SITENO should be used to derive SITEID for SDTM, depending upon sponsor’s site identification scheme.', :sdtm_category_id => '', :core => 'Highly
Recommended', :definition => 'Unique identifier for the study site;
however, SITEID is also unique within a submission.', :data_collection_field => 'Site Identifier Within
a Study', :domain_id => '39' },
  { :variable_name => 'SUBJID', :number => '3', :completion_instructions => 'Record the identifier for the subject.', :sponsor_info => 'EDC: The subject identifiers may be provided to the site using a pre-populated list in the system.', :sdtm_category_id => '', :core => 'Highly
Recommended', :definition => 'Subject identifier for the study.', :data_collection_field => 'Subject Identifier', :domain_id => '39' },
  { :variable_name => 'USUBJID', :number => '4', :completion_instructions => 'Record the identifier for the subject.', :sponsor_info => 'EDC: The subject identifiers may be provided to the site using a pre-populated list in the system.', :sdtm_category_id => '', :core => 'Optional', :definition => 'Unique subject identifier within a
submission.', :data_collection_field => 'Unique Subject
Identifier', :domain_id => '39' },
  { :variable_name => 'INVID', :number => '5', :completion_instructions => 'Record the sponsor-defined identifier for
your site investigator.', :sponsor_info => 'Study level – Not needed if SITEID is
equivalent to INVID.', :sdtm_category_id => '', :core => 'Optional', :definition => 'Investigator identifier.', :data_collection_field => 'Investigator Identifier', :domain_id => '39' },
  { :variable_name => 'SPID', :number => '6', :completion_instructions => 'Not applicable.', :sponsor_info => 'When used, this is typically pre-printed/
pre-populated.', :sdtm_category_id => '', :core => 'Optional', :definition => 'Optional sponsor-defined reference
number. Perhaps pre-printed/pre- populated as an explicit line
identifier or defined in the sponsor’s operational database (e.g., line
number on a Disposition page).', :data_collection_field => 'Sponsor-Defined
Identifier', :domain_id => '39' },
  { :variable_name => 'VISIT / VISITNUM', :number => '1', :completion_instructions => 'When applicable (e.g., on paper CRFs),
record the visit name and/or visit number.', :sponsor_info => 'This is typically pre-printed/pre-
populated.', :sdtm_category_id => '', :core => 'Optional', :definition => 'Visit Name / Visit Number.', :data_collection_field => 'Visit', :domain_id => '39' },
  { :variable_name => 'VISDAT', :number => '2', :completion_instructions => 'Record the date the visit took place.', :sponsor_info => 'This may be recorded in either the header
 of the CRF or in the body of the CRF.', :sdtm_category_id => '', :core => 'Highly
Recommended', :definition => 'Date the visit took place.', :data_collection_field => 'Date of Visit', :domain_id => '39' },
  { :variable_name => 'VISTIM', :number => '3', :completion_instructions => 'Record the time the visit took place.', :sponsor_info => 'This may be useful for Phase I trials.', :sdtm_category_id => '', :core => 'Optional', :definition => 'Time the visit took place.', :data_collection_field => 'Time of Visit', :domain_id => '39' }
])
# End auto-generated file.
