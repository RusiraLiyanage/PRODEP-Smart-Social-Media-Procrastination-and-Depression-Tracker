from flask import Flask, render_template , request , jsonify,url_for
from flask_pymongo import PyMongo
from pymongo import MongoClient
from bson.json_util import dumps
from bson.objectid import ObjectId
from flask import jsonify,request
from werkzeug.security import generate_password_hash,check_password_hash
from chat import get_response
import helasentilex
import thebot
import thebot2
import thebot3
import json
import os
from datetime import datetime
from textblob import TextBlob as TB
path1 = "C:/Users/HP/Documents/UiPath/Sentiment Analysis vibes"
path2 = "C:/Users/HP/Documents/UiPath/Sencat Demo"
path_to_duration = "C:/Users/HP/Documents/UiPath/Sentiment Analysis vibes"
import os
from google.cloud import translate_v2 as translate

os.environ["GOOGLE_APPLICATION_CREDENTIALS"] = r"E:\4th year Research\Chatbot vibes\TranslationAPI\My Service Account Key.json"
translateClient = translate.Client()
#import time

app = Flask(__name__)

cluster = "mongodb+srv://Rusira:Rusira123@cluster0.fywelar.mongodb.net/Testing?retryWrites=true&w=majority"

#mongo = PyMongo(app)
client = MongoClient(cluster)


@app.get("/")
def index_get():
    return render_template("base.html")

@app.post("/predict")
def predict():
    text = request.get_json().get("message")
    response = get_response(text)
    message = {"answer": response}
    #time.sleep(2)
    return jsonify(message)

@app.post("/sentiment")
def sentiment_analysis():
    text = request.get_json().get("message")
    response = helasentilex.sentiments(text)
    analysis = {"lexicon": response}

    return jsonify(analysis)

@app.post("/automation-sentiment")
def automation_trigger():
    text1 = request.get_json().get("name")
    print(text1)
    thebot.bot_executor()
    message = {"message": "Automation Bot Successfully triggerd"}
    return jsonify(message)

@app.post("/automation-sencat")
def automation_trigger2():
    text2 = request.get_json().get("name")
    print(text2)
    thebot2.bot_executor()
    message = {"message": "Sentiment Analysis Automation Successfully Triggerd"}
    return jsonify(message)

@app.post("/automation-data-analytics")
def automation_trigger3():
    text2 = request.get_json().get("name")
    print(text2)
    # generating the relevent folder
    now = datetime.now()
    dt_string = now.strftime("%m-%d-%Y")
    dt_string2 = now.strftime("%m-%d-%Y %H-%M-%S")
    print(dt_string)
    folder_name = "Data Analytics"
    if not os.path.exists(path1 + "/" + dt_string + "/" + folder_name):
        os.makedirs(path1 + "/" + dt_string + "/" + folder_name)
    else:
        print("folder has been already created in Sentiment Analysis Demo Vibes")
    endResult = thebot3.bot_executor()
    message = {"message": endResult}
    return jsonify(message)

@app.post("/automation-data-analytics-sencat")
def automation_trigger5():
    text2 = request.get_json().get("name")
    print(text2)
    # generating the relevent folder
    now = datetime.now()
    dt_string = now.strftime("%m-%d-%Y")
    dt_string2 = now.strftime("%m-%d-%Y %H-%M-%S")
    print(dt_string)
    folder_name = "Data Analytics"
    if not os.path.exists(path2 + "/" + dt_string + "/" + folder_name):
        os.makedirs(path2 + "/" + dt_string + "/" + folder_name)
    else:
        print("folder has been already created in Sentiment Analysis Demo Vibes")
    endResult = thebot3.bot_executor()
    message = {"message": endResult}
    return jsonify(message)

@app.route('/add', methods = ['POST'])
def add_to_mongo():
    db = client.Testing
    sample = db.sample
    _json = request.json
    _name = _json['name']
    the_array = request.get_json().get("array")
    theArray = the_array
    #theArray = ("This is good", "This is bad", "I don't know")
    #yeps = ",".join(theArray)
    #into = ""
    #yeps = f"{ {yeps} }"
    #print(yeps)
    #hoo = json.dumps(yeps)
    #print(hoo)
    # generating the folder and writing into a file
    now = datetime.now()
    dt_string = now.strftime("%m-%d-%Y")
    dt_string2 = now.strftime("%m-%d-%Y %H-%M-%S")
    print(dt_string)
    folder_name = dt_string
    if not os.path.exists(path2 + "/" + folder_name):
        os.makedirs(path2 + "/" + folder_name)
    else:
        print("folder has been already created in path2")
    #if not os.path.exists(path2):
       # os.makedirs(f'{path2}/{folder_name}')
   # else:
        #print("folder has been already created in path2")
    #file = open(f'{path1}/{folder_name}/{dt_string2}.txt',"w")
    with open(f'{path2}/{folder_name}/{dt_string2}.txt',"a",encoding="utf-8") as file:
        for i in theArray:
            print(i)
            file.write(i + "\n")
    if _name and request.method == 'POST':
        # to send data to mongodb
        #id = mongo.db.insert({'name': _name, 'email': _email})
        #result = sample.insert_one({"name": _name, "result": yeps})
        resp = jsonify({"message": "Data inserted successfully"})
        resp.status_code = 200
        return resp

@app.post("/sinhala-english")
def translation_trigger():
    text3 = request.get_json().get("name")
    the_array = request.get_json().get("array")
    print(text3)
    now = datetime.now()
    dt_string = now.strftime("%m-%d-%Y")
    dt_string2 = now.strftime("%m-%d-%Y %H-%M-%S")
    print(dt_string)
    folder_name = dt_string
    if not os.path.exists(path1 + "/" + folder_name):
        os.makedirs(path1 + "/" + folder_name)
    else:
        print("folder has been already created in path2")
    with open(f'{path1}/{folder_name}/{dt_string2}.txt',"a",encoding="utf-8") as file:
        for i in the_array:
             try:
                i = str(i)
                # ---- cleaning the translated text ------------------
                i = i.replace(","," ")
                i = i.replace(";"," ")
                i = i.replace("."," ")
                i = i.replace("//"," ")
                i = i.replace(":"," ")
                # -----------------------------------------------------
                #translated_text = TB(i).translate(from_lang=u'si', to=u'en')
                target = "en"
                translated_text = translateClient.translate(i,target_language = target,)
                string_translation = str(translated_text["translatedText"])
                string_translation = string_translation.replace(","," ")
                string_translation = string_translation.replace("&#39;","'")
                
                print(string_translation)
                file.write(string_translation + "\n")
             except:
                print("Translation API returned the input string unchanged.")
                string_translation = i
                print(string_translation)
                file.write(string_translation + "\n")
    #tweet = 'ඉන්දියාවේ සිට ආයුබෝවන්'
    message = {"message": "Data has been successfully translated and saved"}
    return jsonify(message)

@app.post("/test-api")
def automation_triggerTest():
    text2 = request.get_json().get("name")
    print(text2)
    try:
        # ---- cleaning the translated text ------------------
        print(text2)
        # -----------------------------------------------------
        translated_text = TB(text2).translate(from_lang=u'si', to=u'en')
        target = "en"
        translated_text = translateClient.translate(text2,target_language = target,)
        string_translation = (translated_text["translatedText"])
        string_translation = str(translated_text)
        string_translation = string_translation.replace(","," ")
        print(string_translation)
    except:
        print("Translation API returned the input string unchanged.")
        string_translation = text2
    
    #thebot2.bot_executor()
    message = {"message": string_translation}
    return jsonify(message)

@app.post("/test-api2")
def automation_triggerTest2():
    text2 = request.get_json().get("name")
    print(text2)
    endResult = thebot.bot_executor()
    #thebot2.bot_executor()
    message = {"message": endResult}
    return jsonify(message)

# ------------------------------------------------------------------------------------
@app.post("/writeExtraInfoToNotePad")
def helping_the_mongo():
    _json = request.json
    _name = _json['userName']
    _startTime = _json['startTime']
    _theTime = _json["theTime"]
    _theDate = _json["theDate"]
    _theMonth = _json["theMonth"]
    _theYear = _json["theYear"]
    _theDuration = _json["theDuration"]
    # -----------------------------------------------
    now = datetime.now()
    dt_string = now.strftime("%m-%d-%Y")
    dt_string2 = now.strftime("%m-%d-%Y %H-%M-%S")
    print(dt_string2)
    # -----------------------------------------------
    folder_name = dt_string
    if not os.path.exists(path_to_duration + "/" + folder_name + "/" + "Duration"):
        os.makedirs(path_to_duration + "/" + folder_name + "/" + "Duration")
    else:
        print("folder has been already created in path_to_duration")

    with open(f'{path_to_duration}/{folder_name}/Duration/{dt_string2}.txt',"a",encoding="utf-8") as file:
            file.write(_name + "\n")
            file.write(_theDate + "\n")
            file.write(_theTime + "\n")
            file.write(_startTime + "\n")
            file.write(_theMonth + "\n")
            file.write(_theYear + "\n")
            file.write(_theDuration + "\n")
    if _name and request.method == 'POST':
        # to send data to mongodb
        #id = mongo.db.insert({'name': _name, 'email': _email})
        #result = sample.insert_one({"name": _name, "result": yeps})
        resp = jsonify({"message": "Extra information has been successfully written"})
        resp.status_code = 200
        return resp

        
if __name__ == "__main__":
    app.run(debug=True,host= "192.168.8.183")

