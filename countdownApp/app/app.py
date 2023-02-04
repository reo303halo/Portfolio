from flask import Flask, render_template, request, flash, Response
from countdown import countdownInSeconds, renderTime, validateSeconds # from countdown.py
from datetime import datetime

app = Flask(__name__)
app.secret_key = "__Hello__Apple__"


@app.route("/", methods = ["GET", "POST"])
def index():
    if time_feed() == "Happy Birthday Steve Jobs!!":
        flash("Come back tomorrow to see the countdown! You can still try the button though!")
    else:
        flash("Can you figure out who?")

    return render_template("index.html")


@app.route("/guess", methods = ["GET", "POST"])
def greet():
    guess = request.form["answer"].title()
    if guess == "Steve Jobs":
        flash("Correct!")
        flash("Steve Jobs, the co-founder, chairman, and CEO of Apple was born 24th of February 1955!")
    
    else:
        flash(f'{guess} might be true, but not the person I was thinking about!')
        flash("You are very welcome to try again!")

    return render_template("index.html")


@app.route('/time_feed')
def time_feed():
    date = 'Feb 24'              #Format: Jan 4, Feb 28,...
    year = datetime.now().year
    seconds = countdownInSeconds(date, year)

    if validateSeconds(seconds) == False:
        return "Happy Birthday Steve Jobs!!"
    else:
        return Response(renderTime(seconds), mimetype = 'text') 


if __name__ == '__main__':
    app.run()