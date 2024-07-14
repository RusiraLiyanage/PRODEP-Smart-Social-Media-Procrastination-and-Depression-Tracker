import psutil
import os
import time

PROCESS_NAME = 'Sencat.Demo.Updated'
EXECUTOR_PATH = r"C:\Users\HP\AppData\Local\Programs\UiPath\Studio\UiRobot.exe"


def bot_executor():
    #while True:
        theReturn = []
        for proc in psutil.process_iter():
            try:
        # Get process name & pid from process object.
                processName = proc.name()
                processID = proc.pid
                #print(processName , ' ::: ', processID)
                theReturn.append(processName)
            except (psutil.NoSuchProcess, psutil.AccessDenied, psutil.ZombieProcess):
                pass
        #process_names = (process_names.name() for process_names in psutil.process_iter())
        #print(str(process_names) + " are the processers")
        process_names = theReturn
        if "UiPath.Executor.exe" not in process_names:
            try:
                os.popen(f'{EXECUTOR_PATH} execute -p {PROCESS_NAME}')
                print("Job Started Successfully!")
            except:
                print("Exception Occurred Exception")
                pass
        else:
            print("Job running already")
        return "Automation Bot 2 was successfully triggerd"
        # Pause the script for 15 minutes.
        #time.sleep(900)


#if __name__ == '__main__':
   # bot_executor()