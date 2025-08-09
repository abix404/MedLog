% ------------ Symptoms Database ------------
% Define symptoms for each patient
symptom(mukit, fever).
symptom(mukit, cough).
symptom(mukit, sore_throat).

symptom(sadman, chest_pain).
symptom(sadman, difficulty_breathing).
symptom(sadman, unconsciousness).

symptom(nirob, fatigue).
symptom(nirob, weight_gain).
symptom(nirob, high_blood_pressure).

symptom(rakib, fever).
symptom(rakib, dry_cough).
symptom(rakib, loss_of_taste).
symptom(rakib, headache).

symptom(lamia, frequent_urination).
symptom(lamia, excessive_thirst).
symptom(lamia, unexplained_weight_loss).

symptom(tuhin, fever).
symptom(tuhin, rash).
symptom(tuhin, joint_pain).

% ------------ Risk Factor Database ------------
risk_factor(nirob, obesity).
risk_factor(lamia, family_history_diabetes).
risk_factor(sadman, smoker).
risk_factor(rakib, travel_history).

% ------------ Allergy Database ------------
allergy(mukit, penicillin).
allergy(sadman, aspirin).

% ------------ Disease Diagnosis ------------
has_disease(P, flu) :-
    symptom(P, fever),
    symptom(P, cough),
    symptom(P, sore_throat).

has_disease(P, covid19) :-
    symptom(P, fever),
    symptom(P, dry_cough),
    symptom(P, loss_of_taste).

has_disease(P, hypertension) :-
    symptom(P, fatigue),
    symptom(P, weight_gain),
    symptom(P, high_blood_pressure).

has_disease(P, diabetes) :-
    symptom(P, frequent_urination),
    symptom(P, excessive_thirst),
    symptom(P, unexplained_weight_loss).

has_disease(P, dengue) :-
    symptom(P, fever),
    symptom(P, rash),
    symptom(P, joint_pain).

% ------------ Emergency Alert System ------------
emergency(P) :-
    symptom(P, chest_pain),
    symptom(P, difficulty_breathing),
    symptom(P, unconsciousness).

% ------------ Treatment Suggestions ------------
treatment(flu, 'Rest, fluids, and paracetamol').
treatment(covid19, 'Isolate, monitor oxygen level, consult a doctor').
treatment(hypertension, 'Regular exercise, reduce salt intake, monitor BP').
treatment(diabetes, 'Maintain healthy diet, monitor blood sugar, medication if prescribed').
treatment(dengue, 'Drink fluids, take paracetamol, avoid aspirin, monitor platelets').

% ------------ Lifestyle Advice ------------
lifestyle_advice(P, 'Exercise daily and maintain a low-sodium diet') :-
    has_disease(P, hypertension).

lifestyle_advice(P, 'Maintain hygiene and boost immunity') :-
    has_disease(P, flu).

lifestyle_advice(P, 'Check blood sugar regularly and avoid high-sugar foods') :-
    has_disease(P, diabetes).

lifestyle_advice(P, 'Use mosquito protection and avoid stagnant water areas') :-
    has_disease(P, dengue).

% ------------ Preventive Measures ------------
preventive(covid19, 'Wear masks, sanitize hands, maintain social distancing').
preventive(flu, 'Get vaccinated, maintain hygiene').
preventive(dengue, 'Use mosquito nets, avoid stagnant water').
preventive(hypertension, 'Reduce salt, manage stress, exercise').
preventive(diabetes, 'Healthy diet, regular exercise, maintain ideal body weight').

% ------------ Symptom Severity Tracking ------------
severity(fever, moderate).
severity(cough, mild).
severity(sore_throat, mild).
severity(chest_pain, high).
severity(difficulty_breathing, high).
severity(unconsciousness, critical).
severity(rash, mild).
severity(joint_pain, moderate).

% ------------ Hospital Referral System ------------
refer_hospital(P, 'ICU Required') :-
    emergency(P).

refer_hospital(P, 'Specialist Consultation Needed') :-
    has_disease(P, diabetes);
    has_disease(P, hypertension).

refer_hospital(P, 'Home Care Possible') :-
    has_disease(P, flu);
    has_disease(P, dengue).

% ------------ Multi-Disease Diagnosis Suggestion ------------
possible_diseases(P, Diseases) :-
    findall(D, has_disease(P, D), Diseases).

% ------------ Recursive Rule: Listing All Symptoms ------------
list_symptoms(P, [S|T]) :-
    symptom(P, S),
    retract(symptom(P, S)),
    list_symptoms(P, T).
list_symptoms(_, []).

