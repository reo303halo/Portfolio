from datetime import datetime

def countdownInSeconds(date, year): 

    yearInSeconds = 31536000
    leapYearInSeconds = 31622400
    countdownDate = datetime.strptime(f'{date} {year} 00:00', '%b %d %Y %H:%M')

    remainingSeconds = int((countdownDate - datetime.now()).total_seconds())
    if remainingSeconds < - 86400:
        if (year % 4 == 0) and (year % 100 != 0) or (year % 400 == 0):
            remainingSeconds += leapYearInSeconds 
        else:
            remainingSeconds += yearInSeconds

    return remainingSeconds


def renderTime(seconds):

    minutes = seconds // 60 
    hours = minutes // 60 
    days = hours // 24
    remainingHours = hours % 24
    remainingMinutes = minutes % 60 
    remainingSeconds = seconds % 60 

    return "{} days {} hours {} minutes {} seconds left".format(days, remainingHours, remainingMinutes, remainingSeconds)


def validateSeconds(seconds):
    if seconds < 0:
        return False
    else:
        return True