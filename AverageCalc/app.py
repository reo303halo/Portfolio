from flask import Flask, render_template, flash, request
from functions import writeToFile, fromFileToLst, findAverage

app = Flask(__name__)
app.secret_key = "qweasd"

savefile = "numbersFile.txt"


@app.route("/")
def home():
    flash("You are welcome to add a number to my list!")

    numberLst = fromFileToLst(savefile)    
    average = findAverage(numberLst)

    return render_template('index.html', average = format(average, ".2f"), total_of_numbers = len(numberLst))


@app.route("/add_number", methods = ["POST", "GET"])
def add_number():
    number = request.form["number_input"]

    try:
        writeToFile(int(number), "numbersFile.txt")
        flash("Thank you!")
        flash("You are welcome to add more number!")

    except:
        flash("Please enter an integer(number without decimal, eg: 12, 23, 65....)")
        flash("You are welcome to try again!")

    numberLst = fromFileToLst(savefile)    
    average = findAverage(numberLst)
    
    return render_template("index.html", average = format(average, ".2f"), total_of_numbers = len(numberLst))


if __name__ == '__main__':
    app.run(debug = True)