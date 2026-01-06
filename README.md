Call Logs Case Study

This project analyzes support call logs to understand how product changes affected customer support demand and call behavior.

The analysis focuses on two events:
	•	Billing Workflow Update
	•	Login MFA Rollout

Using SQL, I compared call volume, call length, and call topics before and after each event to identify changes in customer support patterns and highlight areas for improvement.

What this project covers
	•	Cleaning and preparing raw call log data
	•	Removing duplicate records
	•	Creating baseline metrics for call volume and call length
	•	Pre- and post-event analysis
	•	Normalizing results using per-day averages
	•	Analyzing changes in call categories (Login, Billing)
	•	Translating findings into clear business recommendations

Key findings
	•	The Login MFA rollout increased login-related calls per day without increasing total daily call volume, indicating a shift in call mix rather than overall demand.
	•	The Billing Workflow Update increased both billing calls per day and average call length, suggesting added complexity or customer confusion after the change.

Tools used
	•	SQL (MySQL)

Files in this repository
	•	data_cleaning.sql – data preparation and deduplication
	•	login_mfa_analysis.sql – analysis of the Login MFA rollout
	•	billing_event_analysis.sql – analysis of the Billing Workflow Update

This case study reflects how a data analyst would approach a real support dataset: validate the data, analyze changes over time, and communicate results in a way that supports product and support decisions.
