# ********RoostGPT********

# Test generated by RoostGPT for test API-test-Vtal using AI Type Open AI and AI Model gpt-4-turbo
# 
# ROOST_METHOD_HASH=969e323815
# ROOST_METHOD_SIG_HASH=e7177c53aa
# 
#  ########## Scenario ########## 
# 
# {
#   feature: 'Feature: Schedule an appointment and notify via communication API',
#   background: 'Background:\n' +
#     "        * def appointmentApiURL = 'http://127.0.0.1:4010'\n" +
#     "        * def appointmentPayload = read('appointmentRequest.json')\n" +
#     "        * def communicationPayload = read('communicationRequest.json')\n" +
#     "        * def communicationApiURL = 'http://127.0.0.1:4001'",
#   rule: null,
#   scenario: {
#     title: 'Scenario: Post an appointment and notify about it',
#     steps: "Given path '/searchTimeSlot'\n" +
#       'And param addressId = 17713\n' +
#       "And param subscriberId = 'VTAL001'\n" +
#       "And param associatedDocument = 'VTT001'\n" +
#       "And param startDate = '2023-02-08T18:04:28Z'\n" +
#       "And param finishDate = '2023-02-08T18:04:28Z'\n" +
#       "And param orderType = 'Instalacao'\n" +
#       "And param productType = ['Banda Larga']\n" +
#       'When method get\n' +
#       'Then status 200\n' +
#       'And def slotId = response.slots[0].id\n' +
#       '\n' +
#       "        # Assume validation of the slotId and it's successful\n" +
#       '\n' +
#       '        # Step 2: Use the slot ID to create an appointment\n' +
#       "Given path '/appointment'\n" +
#       'And request appointmentPayload\n' +
#       'And set appointmentPayload.appointment.slot.id = slotId\n' +
#       'When method post\n' +
#       'Then status 201\n' +
#       'And def appointmentId = response.appointment.id\n' +
#       '\n' +
#       "        # Assume validation of the appointmentId and it's successful\n" +
#       '\n' +
#       '        # Step 3: Post a communication message using the Communication Management API\n' +
#       '        * url communicationApiURL\n' +
#       "Given path '/listener/communicationMessage'\n" +
#       'And request communicationPayload\n' +
#       'And set communicationPayload.value.id = appointmentId\n' +
#       '        # Set other necessary fields in communicationPayload as required\n' +
#       'When method post\n' +
#       'Then status 204',
#     examples: ''
#   }
# }
# 

# ********RoostGPT********
Feature: Schedule an appointment and notify via communication API

Background:
  * def urlBase = karate.properties['url.base'] || karate.get('urlBase', 'http://localhost:4010')
  * url urlBase
  * def appointmentPayload = read('appointmentRequest.json')
  * def communicationPayload = read('communicationRequest.json')

Scenario: Search for a time slot
  Given path '/searchTimeSlot'
  And param addressId = 17713
  And param subscriberId = 'VTAL001'
  And param associatedDocument = 'VTT001'
  And param startDate = '2023-02-08T18:04:28Z'
  And param finishDate = '2023-02-08T18:04:28Z'
  And param orderType = 'Instalacao'
  And param productType = ['Banda Larga']
  When method get
  Then status 200
  And def slotId = response.slots[0].id

Scenario: Create an appointment using the slot ID
  Given path '/appointment'
  And request appointmentPayload
  And set appointmentPayload.appointment.slot.id = '#(slotId)'
  When method post
  Then status 201
  And def appointmentId = response.appointment.id

Scenario: Post a communication message using the Communication Management API
  * url 'http://127.0.0.1:4001'
  Given path '/listener/communicationMessage'
  And request communicationPayload
  And set communicationPayload.id = '#(appointmentId)'
  When method post
  Then status 204
