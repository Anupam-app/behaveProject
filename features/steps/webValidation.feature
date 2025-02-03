Feature: Wise Staging Environment


  Scenario: Login as tutor
    Given Launch the url "https://staging-web.wise.live"
    Given enter the mobile number"1111100000" and otp"0000"
    Then validate the institute name "Testing Institute"
    And navigate to Group courses
    And click on Classroom for Automated testing
    Then validate classroom page is landed successfully
    And click on live session and select the schedule sessions
    And click on add session and schedule the time for 10PM today
    And click on create
    Then validate the session is visible in timeline
    And validate the session details such as instructor name, session name, session time, upcoming status


