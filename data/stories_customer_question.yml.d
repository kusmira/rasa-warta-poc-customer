version: "2.0"

stories:

# Customer question flow
- story: question general
  steps:
  - intent: customer_question_general
  - action: utter_customer_question_transfer

- story: insurance question without insurance number
  steps:
  - action: insurance_number_form
  - active_loop: insurance_number_form
  - active_loop: null
  - slot_was_set:
    - insurance_number_verified: false
  - action: utter_customer_question_transfer

- story: insurance question with insurance number
  steps:
  - action: insurance_number_form
  - active_loop: insurance_number_form
  - active_loop: null
  - slot_was_set:
    - insurance_number_verified: true
  - action: customer_authentication_form
  - active_loop: customer_authentication_form
  - active_loop: null
  - action: action_perform_customer_authentication
  - checkpoint: customer_question_customer_authentication

- story: status authentication failed
  steps:
  - checkpoint: customer_question_customer_authentication
  - slot_was_set:
    - customer_authenticated: false
  - action: utter_customer_question_transfer

- story: status authentication succeed - consultant direct
  steps:
  - checkpoint: customer_question_customer_authentication
  - slot_was_set:
    - customer_authenticated: true
  - action: action_set_customer_question_path
  - action: action_select_utter_customer_question_bot_info

