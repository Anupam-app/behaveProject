Feature: Signup Form Validation
  As a new user
  I want to register with valid credentials
  So that I can access the system

  Scenario: TC_SIGNUP_001 - Successful registration after correcting invalid password
    Given I am on the signup page
    When I enter a valid email "testuser@example.com"
    And I enter an invalid password "pass"
    And I confirm the password "pass"
    And I click the SIGN UP button
    Then I should see an error message about password requirements
    When I enter a valid password "Passw0rd!"
    And I confirm the password "Passw0rd!"
    And I click the SIGN UP button
    Then the form should submit successfully or show "Email already exists"

  Scenario: TC_SIGNUP_002 - Reject invalid email format
    Given I am on the signup page
    When I enter an invalid email "invalid-email"
    And I enter a valid password "Passw0rd!"
    And I confirm the password "Passw0rd!"
    And I click the SIGN UP button
    Then I should see an error message "User not found"

  Scenario: TC_SIGNUP_003 - Reject mismatched passwords
    Given I am on the signup page
    When I enter a valid email "testuser@example.com"
    And I enter a password "Passw0rd!"
    And I confirm the password "Different!"
    And I click the SIGN UP button
    Then I should see an error message "Passwords do not match"
    And the form should not submit

  Scenario: TC_SIGNUP_004 - Reject empty form submission
    Given I am on the signup page
    When I leave all fields blank
    And I click the SIGN UP button
    Then I should see an error message "Password must contain at least one lowercase letter, uppercase letter, number and special character and be a minimum of 8 characters in length"

  Scenario: TC_SIGNUP_005 - Accept password that just meets requirements
    Given I am on the signup page
    When I enter a valid email "testuser@example.com"
    And I enter a minimum valid password "Passw0rd!"
    And I confirm the password "Passw0rd!"
    And I click the SIGN UP button
    Then the form should submit successfully or show "Email already exists"

  Scenario: TC_SIGNUP_006 - Reject duplicate email registration
    Given I am on the signup page
    And the email "registered@example.com" is already registered
    When I enter the email "registered@example.com"
    And I enter a valid password "Passw0rd!"
    And I confirm the password "Passw0rd!"
    And I click the SIGN UP button
    Then I should see an error message "Email already exists"
    And the form should not submit

    Feature: Onboard OCN Node Process
  As a user
  I want to onboard OCN nodes and wallets
  So that I can manage my nodes effectively

  Scenario: TC_ONBOARD_001 - Successful submission of node details with valid input
    Given I am on the Onboard OCN Node page at Step 1
    When I enter a valid Node ID "NodeID-1"
    And I enter a valid Public IP "128.0.168.1"
    And I select a Node Type "Validator"
    And I click the NEXT button
    Then the form should submit successfully
    And I should be taken to Step 2
    And the preview should display the node details "NodeID-1, Validator, 128.0.168.1"

  Scenario: TC_ONBOARD_002 - Reject invalid Public IP format
    Given I am on the Onboard OCN Node page at Step 1
    When I enter a valid Node ID "NodeID-1"
    And I enter an invalid Public IP "invalid-ip"
    And I select a Node Type "Validator"
    And I click the NEXT button
    Then I should see an error message "Invalid IP address"
    And I should remain on Step 1

  Scenario: TC_ONBOARD_003 - Reject submission if Node Type is not selected
    Given I am on the Onboard OCN Node page at Step 1
    When I enter a valid Node ID "NodeID-1"
    And I enter a valid Public IP "128.0.168.1"
    And I leave the Node Type unselected
    And I click the NEXT button
    Then I should see an error message "Please select your node type"
    And I should remain on Step 1

  Scenario: TC_ONBOARD_004 - Add multiple nodes and display in preview
    Given I am on the Onboard OCN Node page at Step 1
    When I enter NodeID-1, Public IP "128.0.168.1", and Node Type "Validator"
    And I click the ADD NODE button
    And I enter NodeID-2, Public IP "128.0.168.2", and Node Type "RPC"
    And I click the NEXT button
    Then both nodes should be added and shown in the preview
    And I should be taken to Step 2

  Scenario: TC_ONBOARD_005 - Reject submission when required fields are empty
    Given I am on the Onboard OCN Node page at Step 1
    When I leave Node ID, Public IP, and Node Type empty
    And I click the NEXT button
    Then I should see errors for all required fields
    And I should remain on Step 1

  Scenario: TC_ONBOARD_006 - Successful onboarding of nodes and wallets with submission
    Given I am on the Onboard OCN Node page at Step 1
    When I enter a valid Node ID "NodeID-1"
    And I enter a valid Public IP "128.0.168.1"
    And I select a Node Type "Validator"
    And I click the ADD NODE button
    And I enter a second node with Node ID "NodeID-3", Public IP "999.999.999.999", and Node Type "RPC"
    And I click the NEXT button
    And I enter a valid Wallet Address "0x88fA61d2fA1A13aad8Fb5b8030372B4A159BbbDFb"
    And I select a Wallet Permission "TRANSACTION_SUBMIT"
    And I click the ADD WALLET button
    And I enter a second wallet with Wallet Address "0x88fA61d2fA1A13aad8Fb5b8030372B4A159BbbDFb" and Permission "CONTRACT_DEPLOY"
    And I click the NEXT button
    And I verify the preview sections for nodes and wallets
    And I click the SUBMIT button
    Then the submission should be successful
    And I should be redirected to a confirmation page or dashboard

  Scenario: TC_ONBOARD_007 - Remove selected nodes in Step 1
    Given I am on the Onboard OCN Node page at Step 1 with two nodes added "NodeID-1, Validator, 128.0.168.1" and "NodeID-3, RPC, 999.999.999.999"
    When I select both nodes in the preview section
    And I click the REMOVE SELECTED NODES button
    Then both nodes should be removed from the preview section
    And the preview section should be empty
    When I add a new node with Node ID "NodeID-2", Public IP "128.0.168.2", and Node Type "Validator"
    And I click the NEXT button
    Then the new node should be added to the preview
    And I should be taken to Step 2

  Scenario: TC_ONBOARD_008 - Reject invalid wallet address in Step 2
    Given I am on the Onboard OCN Node page at Step 2 with one node added
    When I enter an invalid Wallet Address "invalid_address"
    And I select a Wallet Permission "TRANSACTION_SUBMIT"
    And I click the ADD WALLET button
    Then I should see an error message "Invalid wallet address"
    And the wallet should not be added to the preview section

  Scenario: TC_ONBOARD_009 - Remove selected wallets in Step 2
    Given I am on the Onboard OCN Node page at Step 2 with two wallets added "0x88fA61d2fA1A13aad8Fb5b8030372B4A159BbbDFb, TRANSACTION_SUBMIT" and "0x88fA61d2fA1A13aad8Fb5b8030372B4A159BbbDFb, CONTRACT_DEPLOY"
    When I select both wallets in the preview section
    And I click the REMOVE SELECTED WALLETS button
    Then both wallets should be removed from the preview section
    And the preview section should be empty
    When I add a new wallet with Wallet Address "0x88fA61d2fA1A13aad8Fb5b8030372B4A159BbbDFb" and Permission "TRANSACTION_SUBMIT"
    And I click the NEXT button
    Then the new wallet should be added to the preview
    And I should be taken to Step 3

  Scenario: TC_ONBOARD_010 - Navigate between steps using Back button while retaining data
    Given I am on the Onboard OCN Node page at Step 3 with two nodes and two wallets added
    When I click the BACK button to return to Step 2
    Then I should be taken to Step 2
    And the wallet preview should show both wallets
    When I click the BACK button again to return to Step 1
    Then I should be taken to Step 1
    And the node preview should show both nodes
    When I click the NEXT button to return to Step 2
    And I click the NEXT button again to return to Step 3
    Then I should be back on Step 3 with all data intact in the previews

  Scenario: TC_ONBOARD_011 - Sort Wallet Preview by ASC
    Given I am on the Onboard OCN Node page at Step 3 with two wallets added "0x88fA61d2fA1A13aad8Fb5b8030372B4A159BbbDFb, TRANSACTION_SUBMIT" and "0x88fA61d2fA1A13aad8Fb5b8030372B4A159BbbDFb, CONTRACT_DEPLOY"
    When I click the dropdown next to the Address column header
    And I select "Sort by ASC"
    Then the wallet entries should be sorted in ascending order by Address
    And the order should be "0x88fA61d2fA1A13aad8Fb5b8030372B4A159BbbDFb, CONTRACT_DEPLOY" followed by "0x88fA61d2fA1A13aad8Fb5b8030372B4A159BbbDFb, TRANSACTION_SUBMIT"

  Scenario: TC_ONBOARD_012 - Sort Wallet Preview by DESC
    Given I am on the Onboard OCN Node page at Step 3 with two wallets added "0x88fA61d2fA1A13aad8Fb5b8030372B4A159BbbDFb, TRANSACTION_SUBMIT" and "0x88fA61d2fA1A13aad8Fb5b8030372B4A159BbbDFb, CONTRACT_DEPLOY"
    When I click the dropdown next to the Address column header
    And I select "Sort by DESC"
    Then the wallet entries should be sorted in descending order by Address
    And the order should be "0x88fA61d2fA1A13aad8Fb5b8030372B4A159BbbDFb, TRANSACTION_SUBMIT" followed by "0x88fA61d2fA1A13aad8Fb5b8030372B4A159BbbDFb, CONTRACT_DEPLOY"

  Scenario: TC_ONBOARD_013 - Hide column in Wallet Preview
    Given I am on the Onboard OCN Node page at Step 3 with two wallets added "0x88fA61d2fA1A13aad8Fb5b8030372B4A159BbbDFb, TRANSACTION_SUBMIT" and "0x88fA61d2fA1A13aad8Fb5b8030372B4A159BbbDFb, CONTRACT_DEPLOY"
    When I click the dropdown next to the Type column header
    And I select "Hide column"
    Then the Type column should be hidden
    And the table should display only the Address column with "0x88fA61d2fA1A13aad8Fb5b8030372B4A159BbbDFb" for both rows
    When I click the dropdown again and select "Manage columns"
    Then the Type column should be listed as hidden and can be toggled back to visible

  Scenario: TC_ONBOARD_014 - Manage columns in Wallet Preview
    Given I am on the Onboard OCN Node page at Step 3 with two wallets added "0x88fA61d2fA1A13aad8Fb5b8030372B4A159BbbDFb, TRANSACTION_SUBMIT" and "0x88fA61d2fA1A13aad8Fb5b8030372B4A159BbbDFb, CONTRACT_DEPLOY"
    When I click the dropdown next to the Address column header
    And I select "Manage columns"
    And I uncheck the Type column to hide it
    And I click Apply
    Then the Type column should be hidden
    And the table should display only the Address column with "0x88fA61d2fA1A13aad8Fb5b8030372B4A159BbbDFb" for both rows
    When I reopen the Manage columns menu and recheck the Type column
    And I click Apply again
    Then the Type column should be restored
    And the table should show both columns again with "0x88fA61d2fA1A13aad8Fb5b8030372B4A159BbbDFb, TRANSACTION_SUBMIT" and "0x88fA61d2fA1A13aad8Fb5b8030372B4A159BbbDFb, CONTRACT_DEPLOY"

  Scenario: TC_ONBOARD_015 - Filter Wallet Preview by Type
    Given I am on the Onboard OCN Node page at Step 3 with two wallets added "0x88fA61d2fA1A13aad8Fb5b8030372B4A159BbbDFb, TRANSACTION_SUBMIT" and "0x88fA61d2fA1A13aad8Fb5b8030372B4A159BbbDFb, CONTRACT_DEPLOY"
    When I click the dropdown next to the Type column header
    And I select "Filter"
    And I select "TRANSACTION_SUBMIT" and apply the filter
    Then the table should only display wallets with Type "TRANSACTION_SUBMIT" as "0x88fA61d2fA1A13aad8Fb5b8030372B4A159BbbDFb, TRANSACTION_SUBMIT"
    When I clear the filter by selecting "Clear Filter"
    Then the table should display both wallets again with "0x88fA61d2fA1A13aad8Fb5b8030372B4A159BbbDFb, TRANSACTION_SUBMIT" and "0x88fA61d2fA1A13aad8Fb5b8030372B4A159BbbDFb, CONTRACT_DEPLOY"

  Scenario: TC_ONBOARD_016 - Prevent adding duplicate wallet addresses in Step 2
    Given I am on the Onboard OCN Node page at Step 2 with one wallet added "0x88fA61d2fA1A13aad8Fb5b8030372B4A159BbbDFb, TRANSACTION_SUBMIT"
    When I enter the same Wallet Address "0x88fA61d2fA1A13aad8Fb5b8030372B4A159BbbDFb"
    And I select a different Wallet Permission "CONTRACT_DEPLOY"
    And I click the ADD WALLET button
    Then I should see an error message "Wallet address already exists"
    And the duplicate wallet should not be added to the preview section
    And the preview section should still show only the original wallet "0x88fA61d2fA1A13aad8Fb5b8030372B4A159BbbDFb, TRANSACTION_SUBMIT"
