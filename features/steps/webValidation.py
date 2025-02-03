import time

from behave import *
from selenium import webdriver
from selenium.webdriver import Keys
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
from selenium.webdriver.common.action_chains import ActionChains


@given('Launch the url "{url}"')
def launchBrowser(context, url):
    context.driver = webdriver.Chrome()
    context.driver.maximize_window()
    context.driver.get(url)
    loginIcon = context.driver.find_element(By.XPATH, "//div[contains(text(),'Login')]")
    wait = WebDriverWait(context.driver, timeout =5)
    wait.until(lambda d: loginIcon.is_displayed())


@given('enter the mobile number"{mobNum}" and otp"{otp}')
def login(context, mobNum, otp):
    wait = WebDriverWait(context.driver, 5)
    actions = ActionChains(context.driver)
    context.driver.find_element(By.XPATH,"//img[contains(@src,'svgs/icon/login/mobile.svg')]").click()
    mobEnter = WebDriverWait(context.driver, 10).until(
        EC.presence_of_element_located((By.XPATH, "//input[@placeholder='Phone number']"))
    )
    mobEnter.send_keys(mobNum)
    getOPtBtn = WebDriverWait(context.driver, 2).until(
        EC.element_to_be_clickable((By.XPATH, "//span[contains(text(),'Get OTP')]")))
    getOPtBtn.click()
    otpPage = context.driver.find_element(By.XPATH,"//p[text()='Enter OTP']")
    wait.until(lambda d: otpPage.is_displayed())
    otp_boxes_list = context.driver.find_elements(By.XPATH, "//input[@autocomplete='one-time-code']")
    for i in range(len(otp_boxes_list)):
        otp_boxes_list[i].send_keys(otp[i])

    verfiyBtn = wait.until(EC.visibility_of_element_located((By.XPATH,"//span[contains(text(),'Verify')]")))
    verfiyBtn.click()


@then(u'validate the institute name "{expectedPageTitle}"')
def validateInstitue(context,expectedPageTitle):
    wait = WebDriverWait(context.driver, 5)
    actualTile = wait.until(EC.visibility_of_element_located((By.XPATH,"//span[contains(text(),'Testing Institute')]")))
    actualPageTitle = actualTile.text
    assert actualPageTitle == expectedPageTitle, f"❌ Text mismatch! Expected: '{expectedPageTitle}',Got: '{actualPageTitle}'"


@then('navigate to Group courses')
def navigateGroupCourses(context):
    wait = WebDriverWait(context.driver, 5)
    groupCourseelement = wait.until(EC.visibility_of_element_located((By.XPATH,"//span[contains(text(),'Group courses ')]")))
    groupCourseelement.click()

@then('click on Classroom for Automated testing')
def classRoom(context):
    wait = WebDriverWait(context.driver, 5)
    classroomElement = wait.until(EC.visibility_of_element_located((By.XPATH,"//div//a[contains(text(),'Classroom for Automated testing')]")))
    classroomElement.click()

@then('validate classroom page is landed successfully')
def validateClassRoom(context):
    wait = WebDriverWait(context.driver, 5)
    classRoomPageTitle = wait.until(EC.visibility_of_element_located((By.XPATH,"// div[text() = 'Classroom for Automated testing']")))
    actualClassroomTitle = classRoomPageTitle.text
    assert actualClassroomTitle == "Classroom for Automated testing", f"❌ Text mismatch! Expected: 'Classroom for Automated testing',Got: '{actualClassroomTitle}'"

@then('click on live session and select the schedule sessions')
def scheduleSession(context):
    wait = WebDriverWait(context.driver, 5)
    livesessionelement = wait.until(EC.visibility_of_element_located((By.XPATH,"//a[text()='Live Sessions']")))
    livesessionelement.click()
    scheduleSessionelement = wait.until(EC.visibility_of_element_located((By.XPATH,"//span[text()=' Schedule Sessions']")))
    scheduleSessionelement.click()
    addSessionBtn = wait.until(EC.visibility_of_element_located((By.XPATH,"//span[contains(@class, 'v-btn__content')][contains(., 'Add session')]")))
    addSessionBtn.click()
    time.sleep(2)


@then('click on add session and schedule the time for 10PM today')
def scheduleTime(context):
    wait = WebDriverWait(context.driver, 5)
    timeUpdate = wait.until(EC.visibility_of_element_located(
        (By.XPATH, "(//div[@class='v-select__slot'])[4]//input[1]")))
    timeUpdate.click()
    timeUpdate.send_keys("10:00")
    timeUpdate.send_keys(Keys.ENTER)
    pmBtn = wait.until(EC.visibility_of_element_located((By.XPATH,"//div[text()='PM']")))
    pmBtn.is_displayed()


@then('click on create')
def create(context):
    wait = WebDriverWait(context.driver, 5)
    createBtn = wait.until(EC.visibility_of_element_located((By.XPATH,"//span[contains(text(),'Create')]")))
    createBtn.click()


@then(u'validate the session is visible in timeline')
def validateTimeline(context):
    wait = WebDriverWait(context.driver, 5)
    timelineSession = wait.until(EC.visibility_of_element_located((By.XPATH,"//div[text()='10:00 PM']/parent::div/../parent::div/../../parent::div//div/div[text()='Live session']")))
    timelineSession.is_displayed()
    timeValidate = wait.until(EC.visibility_of_element_located((By.XPATH,"// div[text() = '10:00 PM']")))
    timeValidate.is_displayed()

@then(u'validate the session details such as instructor name, session name, session time, upcoming status')
def validateSessionDetails(context):
    wait = WebDriverWait(context.driver, 5)
    timelineSession = wait.until(EC.visibility_of_element_located((By.XPATH, "//div[text()='10:00 PM']/parent::div/../parent::div/../../parent::div//div/div[text()='Live session']")))
    timelineSession.is_displayed()
    timeValidate = wait.until(EC.visibility_of_element_located((By.XPATH, "// div[text() = '10:00 PM']")))
    timeValidate.is_displayed()
    date = wait.until(EC.visibility_of_element_located((By.XPATH,"//div[text()='10:00 PM']/parent::div/div[contains(text(),'')]")))
    date.is_displayed()



