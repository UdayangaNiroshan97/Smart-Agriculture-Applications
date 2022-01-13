import os
import numpy as np
import tensorflow as tf
from flask import Flask, request, jsonify
from keras.applications.densenet import preprocess_input
from keras.preprocessing.image import img_to_array
from keras.preprocessing.image import load_img
from werkzeug.utils import secure_filename
import mysql.connector
import json

'''mydb = mysql.connector.connect(
    host="localhost",
    user="root",
    password="",
    database="aswenna_project"
)

mycursor = mydb.cursor()'''

CATEGORIES = []
for i in range(48):
    CATEGORIES.append(str(i))

model = tf.keras.models.load_model(r'D:\project\aswenna_project\model\pest_dens_do.h5')

'''def pest_details(id):
    data = {}
    mycursor = mydb.cursor()
    mycursor.execute("SELECT * FROM pest_disease WHERE id = \"%s\"" % (id))
    data = mycursor.fetchone()
    mycursor.close()
    return data'''


def getPrediction(filename):
    result = 100
    image = load_img('D:/project/aswenna_project/upload/' + filename, target_size=(224, 224))
    image = img_to_array(image)
    image = image.reshape((1, image.shape[0], image.shape[1], image.shape[2]))
    image = preprocess_input(image)
    prediction = model.predict(image)
    for i in range(len(CATEGORIES)):
        if np.round(prediction[0][i]) == 1.0:
            result = i
    return result


UPLOAD_FOLDER = r'D:\project\aswenna_project\upload'

app = Flask(__name__)
app.secret_key = "secret key"
app.config['UPLOAD_FOLDER'] = UPLOAD_FOLDER


@app.route('/prediction', methods=['POST'])
def submit_file():
    if request.method == 'POST':
        if 'file' not in request.files:
            results = "No file part"
            return results
        file = request.files['file']
        if file.filename == '':
            results = "No file selected for uploading"
            return results
        if file:
            filename = secure_filename(file.filename)
            file.save(os.path.join(app.config['UPLOAD_FOLDER'], filename))
            label = getPrediction(filename)
            #result = pest_details(label)
            if label != None:
                print(label)
                return str(label)
            else:
                return "can't identified"


'''@app.route('/cultivation_tips', methods=['POST'])
def submit_tips():
    if request.method == 'POST':
        data = request.data.decode('utf-8')
        loadedjson = json.loads(data)
        if loadedjson['crop_name'] != '' and loadedjson['function'] != '':
            data = {}
            mycursor = mydb.cursor()
            mycursor.execute("SELECT " + loadedjson['function'] + " FROM cultivation_tips WHERE crop_name = \'%s\'" % (
            loadedjson['crop_name']))
            data = mycursor.fetchone()
            return str(data[0])
        else:
            return "requesting without data"
    else:
        return "requesting method error"


@app.route('/pest_and_diseases', methods=['POST'])
def submit_pest_and_diseases():
    if request.method == 'POST':
        data = request.data.decode('utf-8')
        loadedjson = json.loads(data)
        if loadedjson['crop_name'] != '' and loadedjson['stage'] != '':
            data = {}
            mycursor = mydb.cursor()
            mycursor.execute("SELECT " + loadedjson['stage'] + " FROM pest_and_disease WHERE crop_name = \'%s\'" % (
            loadedjson['crop_name']))
            data = mycursor.fetchone()
            return data[0]
        else:
            return "requesting without data"
    else:
        return "requesting method error"
'''

if __name__ == "__main__":
    app.run()
