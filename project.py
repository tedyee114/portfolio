#region 0: import libraries and prepare environment
from flask import Flask, render_template, request, url_for
import sqlite3
import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt
import io
import base64
import pandas as pd
import pathlib
web=True
a=pathlib.Path(__file__).parent.resolve()
if a==r"C:\\Users\\tedye\\Desktop\\db_course\\milesplit":
    web=False

app = Flask(__name__)

#endregion


#region 1: homepage##############################################################################################
@app.route('/')
@app.route('/index')
def index():
    return render_template('index.html')
#endregion


#region 2: results##############################################################################################
@app.route('/results', methods=['GET', 'POST'])
def results():
    if request.method == 'POST' and request.form ['race_id'] is not None:
        race_id = request.form ['race_id']
        if race_id=="1001":
            conn = sqlite3.connect('C:/Users/tedye/Desktop/db_course/project_1.db')
            cursor = conn.cursor()                    # Create a cursor object to execute SQL queries
            cursor.execute("SELECT * from results1")
            output = cursor.fetchall()
            cursor.close()
            conn.close()
            if not output:
                message = 'No Results found'
                return render_template('results.html', message=message)
            else:
                return render_template('results.html', output=output)
            
        if race_id=="1002":
            conn = sqlite3.connect('C:/Users/tedye/Desktop/db_course/project_1.db')
            cursor = conn.cursor()                    # Create a cursor object to execute SQL queries
            cursor.execute("SELECT * from results2")
            output = cursor.fetchall()
            cursor.close()
            conn.close()
            if not output:
                message = 'No Results found'
                return render_template('results.html', message=message)
            else:
                return render_template('results.html', output=output)
    else:
        return render_template('results.html')
    
@app.route('/distplot', methods=['GET', 'POST'])
def distplot():
        if request.method == 'POST':
            conn = sqlite3.connect('C:/Users/tedye/Desktop/db_course/project_1.db')
            cursor = conn.cursor()                    # Create a cursor object to execute SQL queries
            cursor.execute("SELECT course_kilometers, COUNT(*) from course GROUP BY course_kilometers;")
            rows = cursor.fetchall()
            cursor.close()
            conn.close()
            
            distances = []
            counts = []
            
            plt.clf()
            
            for row in rows:
                distances.append(row[0])
                counts.append(row[1])
            x = list(range(len(distances)))     # Create an array of indices for the x-axis

            plt.scatter(x, counts, color='red', s=100)

            plt.xlabel('Distances in Kilometers')                                      # Adding labels and title
            plt.ylabel('Count')
            plt.title('Course Length Distribution')

            plt.xticks(x, distances)                                  # Set the x-axis tick positions and labels
            plt.tick_params(axis='x', colors='blue')

            buffer = io.BytesIO()                               # Save the chart image to a buffer
            plt.savefig(buffer, format='png')
            buffer.seek(0)

            image_base64 = base64.b64encode(buffer.getvalue()).decode()      # Convert the image buffer to base64 string

            chart_image = f"data:image/png;base64,{image_base64}"           # Generate the chart image URL

            return render_template('results.html', chart_image=chart_image)
        else:
            return render_template('results.html')
#endregion


#region 3: rankings##############################################################################################
@app.route('/rankings', methods=['GET', 'POST'])
def rankings():
    if request.method == 'POST' and request.form ['athlete_id'] is not None:
        athlete_id=request.form ['athlete_id']
        print ('ath',athlete_id)
        conn = sqlite3.connect('C:/Users/tedye/Desktop/db_course/project_1.db')
        cursor = conn.cursor()                    # Create a cursor object to execute SQL queries
        cursor.execute("SELECT * from (select athlete.athlete_id, athlete_fname, athlete_lname, time,\
                       rank () over (order by time) from athlete left join results2 on athlete.athlete_id=results2.athlete_id) where athlete_id=?", (athlete_id,))
        output = cursor.fetchall()
        cursor.close()
        conn.close()

        if not output:
            message = 'No athlete found'
            return render_template('rankings.html', message=message)
        else:
            return render_template('rankings.html', output=output)
        
    else:
        return render_template('rankings.html')

@app.route('/timeplot', methods=['GET', 'POST'])
def timpelot():
    if request.method == 'POST' and request.form ['timeplot'] is not None:
        print("timeplot", request.form ['timeplot'])
        conn = sqlite3.connect('C:/Users/tedye/Desktop/db_course/project_1.db')
        cursor = conn.cursor()                    # Create a cursor object to execute SQL queries
        cursor.execute("SELECT athlete_id, time from results1 order by athlete_id")
        rows = cursor.fetchall()
        cursor.close()
        conn.close()
             
        athlete_id = []
        time = []

        plt.clf()
        
        for i in rows:
            athlete_id.append(i[0])
            time.append(float(i[1]))
        x = list(range(len(athlete_id)))     # Create an array of indices for the x-axis

        plt.scatter(x, time, color='red')

        plt.xlabel('Athlete_ID')                                      # Adding labels and title
        plt.ylabel('Time')
        plt.title('Race 1001 Time Distribution')

        plt.xticks(x, athlete_id)                                  # Set the x-axis tick positions and labels
        plt.tick_params(axis='x', colors='blue')

        buffer = io.BytesIO()                               # Save the chart image to a buffer
        plt.savefig(buffer, format='png')
        buffer.seek(0)

        image_base64 = base64.b64encode(buffer.getvalue()).decode()      # Convert the image buffer to base64 string

        chart = f"data:image/png;base64,{image_base64}"           # Generate the chart image URL

        return render_template('rankings.html', chart_image=chart)
        
    else:
        return render_template('rankings.html')
#endregion


#region 4: calendar##############################################################################################
@app.route('/calendar', methods=['GET', 'POST'])
def calendar():
    if request.method == 'POST':
        # Establish a connection to the SQLite database
        conn = sqlite3.connect('C:/Users/tedye/Desktop/db_course/project_1.db')
        cursor = conn.cursor()                    # Create a cursor object to execute SQL queries
        cursor.execute("SELECT * from race ORDER BY race_date")
        output = cursor.fetchall()
        cursor.close()
        conn.close()
        
        print(output)

        if not output:
            message = 'No Races found'
            return render_template('calendar.html', message=message)
        else:
            return render_template('calendar.html', output=output)
    else:
        return render_template('calendar.html')
#endregion


#region 5: athletes##############################################################################################
@app.route('/athletes', methods=['GET', 'POST'])
def athletes():
    if request.method == 'POST':
        needall = request.form ['athlete_id']
        athlete_id = request.form ['athlete_id']
                
        if needall or athlete_id:
        # Establish a connection to the SQLite database
            conn = sqlite3.connect('C:/Users/tedye/Desktop/db_course/project_1.db')
            cursor = conn.cursor()                    # Create a cursor object to execute SQL queries
            cursor.execute("SELECT * from (select athlete.athlete_id, athlete_fname, athlete_lname, results1.race_id,\
                results1.time, results2.race_id, results2.time from athlete left join results1 on athlete.athlete_id=results1.athlete_id\
                left join results2 on athlete.athlete_id = results2.athlete_id) where athlete_id=?", (athlete_id,))
            output = cursor.fetchall()
            cursor.close()
            conn.close()
            if not needall:
                message = 'No Races found'
                return render_template('athletes.html', message=message)
            else:
                return render_template('athletes.html', output=output)

    else:
        return render_template('athletes.html')
#endregion


#region 6: upload##############################################################################################
@app.route('/upload', methods=['GET', 'POST'])
def upload():
    if request.method == 'POST':
        tochange=request.form ['tochange']
        print(tochange)
        if tochange=='1001':
            category=request.form ['category']
            time=request.form ['time']
            athlete_id=request.form ['athlete_id']
            conn = sqlite3.connect('C:/Users/tedye/Desktop/db_course/project_1.db')
            cursor = conn.cursor()                    # Create a cursor object to execute SQL queries
            cursor.execute("SELECT MAX(participant_id) FROM results1")
            max_participant_id = cursor.fetchone() # returns one-element tuple (id,)
            max_participant_id = max_participant_id[0] # extract id as digits
            if max_participant_id is None:
                participant_id = 1
            else:
                participant_id = max_participant_id + 1
            
            cursor.execute("SELECT * from results1")
            cursor.execute("insert into results1 (participant_id, category, time, athlete_id, race_id) values(?, ?, ?, ?, ?)", (participant_id,category,time,athlete_id,1001))
            cursor.execute("SELECT * from results1")
            output = cursor.fetchall()
            cursor.close()
            conn.close()
            
            if not output:
                message = 'No Races found'
                return render_template('upload.html', message=message)
            else:
                return render_template('upload.html', output=output)
        
        elif tochange=='1002':
            category=request.form ['category']
            time=request.form ['time']
            athlete_id=request.form ['athlete_id']
            conn = sqlite3.connect('C:/Users/tedye/Desktop/db_course/project_1.db')
            cursor = conn.cursor()                    # Create a cursor object to execute SQL queries
            cursor.execute("SELECT MAX(participant_id) FROM results2")
            max_participant_id = cursor.fetchone() # returns one-element tuple (id,)
            max_participant_id = max_participant_id[0] # extract id as digits
            if max_participant_id is None:
                participant_id = 1
            else:
                participant_id = max_participant_id + 1
            
            cursor.execute("SELECT * from results2")
            cursor.execute("insert into results2 (participant_id, category, time, athlete_id, race_id) values(?, ?, ?, ?, ?)", (participant_id,category,time,athlete_id,1001))
            cursor.execute("SELECT * from results2")
            output = cursor.fetchall()
            cursor.close()
            conn.close()

            if not output:
                message = 'No Races found'
                return render_template('upload.html', message=message)
            else:
                return render_template('upload.html', output=output)
            
        elif tochange=='athlete':
            athlete_fname=request.form ['athlete_fname']
            athlete_lname=request.form ['athlete_lname']
            team_id=request.form ['team_id']
            conn = sqlite3.connect('C:/Users/tedye/Desktop/db_course/project_1.db')
            cursor = conn.cursor()                    # Create a cursor object to execute SQL queries
            cursor.execute("SELECT MAX(athlete_id) FROM athlete")
            max_athlete_id = cursor.fetchone() # returns one-element tuple (id,)
            max_athlete_id = max_athlete_id[0] # extract id as digits
            if max_athlete_id is None:
                athlete_id = 1
            else:
                athlete_id = max_athlete_id + 1
            
            cursor.execute("SELECT * from athlete")
            cursor.execute("insert into athlete (athlete_id, athlete_fname, athlete_lname, team_id) values(?, ?, ?, ?)", (athlete_id,athlete_fname,athlete_lname,team_id,))
            cursor.execute("SELECT * from athlete")
            output = cursor.fetchall()
            cursor.close()
            conn.close()
            print (output)
            if not output:
                message = 'No Races found'
                return render_template('upload.html', message=message)
            else:
                return render_template('upload.html', output=output)
            
    else:
        return render_template('upload.html')
#endregion


#region 7: notyet -for nonexistent pages#######################################################################
@app.route('/notyet', methods=['GET', 'POST'])
def notyet():
    if request.method == 'POST':
        # Establish a connection to the SQLite database

        # Generate the chart image URL
        husky_image = "static/husky.png"

        # Render the template with the chart image URL
        return render_template('notyet.html', husky_image=husky_image)

    # Render the template with the initial form
    return render_template('notyet.html')
#endregion

if __name__ == '__main__':
    app.run(debug=True)