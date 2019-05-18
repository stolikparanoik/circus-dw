import barnum
import pandas as pd
import random as rnd
activities = 1000000
viewers = 10000
posts = 1000
events = 250
parts = 25000 #250*100
entertainments = 100
into = 30000
city = []
name = []
surname = []
df = pd.DataFrame({'ID': [], 'IDbussines': [], 'Name': [], 'Surname':[], 'Age': [], 'Fanpages': [], 'Origin': []})
for i in range(viewers):
    zip, city, state = barnum.create_city_state_zip()
    name, surname = barnum.create_name()
    df = df.append({'ID': '%.12g' % i, 'IDbussines': '%.12g' % rnd.randint(10000000000, 99999999999), 'Name': name, 'Surname': surname, 'Age': barnum.create_birthday(10, 80),
                    'Fanpages': '%.12g' % rnd.randint(0, 5), 'Origin': city}, ignore_index=True)

df.to_csv("viewers.csv", index=False)

'''df = pd.DataFrame({'ID': [], 'ViewerID': [], 'PostID': [], 'Like': [], 'Comment':[], 'Share': []})
for i in range(activities):
    df = df.append({'ID': '%.12g' % i, 'ViewerID': '%.12g' % rnd.randint(0, viewers), 'PostID': '%.12g' % rnd.randint(0, posts),
                    'Like': '%.12g' % rnd.randint(0, 1), 'Comment': '%.12g' % rnd.randint(0, 1),
                    'Share': '%.12g' % rnd.randint(0, 1)},
                   ignore_index=True)

df.to_csv("activities.csv", index=False)'''


'''import datetime

dt = datetime.datetime(2012, 1, 1)
end = datetime.datetime(2019, 3, 12, 17, 00)
step = datetime.timedelta(minutes = 5)

result = []

while dt < end:
    result.append(dt.strftime('%Y-%m-%d %H:%M'))
    dt += step

type = ['photographs', 'likecontest', 'commentcontest', 'showadvertisement', 'video', 'artistbio', 'story']
performers = ['Przemek Kudelka', 'Obious Fail', 'Mc Chicken', 'Big Mac', 'Hope Dope',
              'Water Druck', 'Sanman Kontman', 'Cron Bon', 'Garnet	 Dregan',
              'Glyn	Dobbing', 'Olav	Winpenny', 'Sheilah	 Matzeitis', 'Sherry Scourgie',
              'Gisela Slatter', 'Hans Djekic', 'Fidelio Speak']
performance = ['Acrobatics', 'Animal training', 'Artistic cycling', 'Balancing', 'Baton twirling', 'Chinese yo-yo',
               'Clown', 'Fire performance', 'Foot juggling', 'Hand walking', 'Mime',
               'Tightrope walking', 'Unicycle', 'Wheel of death']
df = pd.DataFrame({'ID': [], 'EventID': [], 'DateHour': [], 'Type': [], 'Performer': [], 'Performance': [], 'Site': [],
                   'Event': []})
for i in range(posts):
    df = df.append({'ID': '%.12g' % i, 'EventID': '%.12g' % rnd.randint(0, events), 'DateHour': rnd.choice(result),
                    'Type': rnd.choice(type), 'Performer': rnd.choice(performers),
                    'Performance': rnd.choice(performance), 'Site': '%.12g' % rnd.randint(0, 1),
                    'Event': '%.12g' % rnd.randint(0, 1)},
                   ignore_index=True)

df.to_csv("posts.csv", index=False)'''

'''dt = datetime.datetime(2012, 1, 1)
end = datetime.datetime(2019, 3, 12, 17, 00)
step = datetime.timedelta(days = 7)

result = []

while dt < end:
    result.append(dt.strftime('%Y-%m-%d'))
    dt += step

df = pd.DataFrame({'ID': [], 'DateHour': [], 'Going': [], 'Maybe': [], 'Invited': []})
for i in range(events):
    df = df.append({'ID': '%.12g' % i, 'DateHour': rnd.choice(result), 'Going': '%.12g' % rnd.randint(0, 1),
                    'Maybe': '%.12g' % rnd.randint(0, 1), 'Invited': '%.12g' % rnd.randint(0, 1)},
                   ignore_index=True)

df.to_csv("events.csv", index=False)'''

'''dt = datetime.datetime(2012, 1, 1)
end = datetime.datetime(2019, 3, 12, 17, 00)
step = datetime.timedelta(minutes = 5)

result = []

while dt < end:
    result.append(dt.strftime('%Y-%m-%d %H:%M'))
    dt += step

df = pd.DataFrame({'ID': [], 'ViewerID': [], 'EventID': [], 'DateHour': []})
for i in range(parts):
    df = df.append({'ID': '%.12g' % i, 'ViewerID': '%.12g' % rnd.randint(0, viewers), 'EventID': '%.12g' % rnd.randint(0, events),
                    'DateHour': rnd.choice(result)},
                   ignore_index=True)

df.to_csv("parts.csv", index=False)'''

'''genre = ['comedy', 'animation', 'music', 'political', 'fantasy', 'drama', 'hadcore', 'classy', 'throwbacks', 'social']
name = ['statuesque','illegal', 'friends', 'dazzling', 'beef', 'fragile', 'fertile', 'back', 'hilarious', 'wholesale', 'analyse', 'spare']
df = pd.DataFrame({'ID': [], 'Followers': [], 'Genre': [], 'Name': []})
for i in range(entertainments):
    df = df.append({'ID': '%.12g' % i, 'Followers':'%.12g' % rnd.randint(100, 100000),
                    'Genre': rnd.choice(genre), 'Name': rnd.choice(name)},
                   ignore_index=True)

df.to_csv("entertainments.csv", index=False)'''

'''dt = datetime.datetime(2012, 1, 1)
end = datetime.datetime(2019, 3, 12, 17, 00)
step = datetime.timedelta(days = 7)

result = []

while dt < end:
    result.append(dt.strftime('%Y-%m-%d'))
    dt += step

df = pd.DataFrame({'ID': [], 'ViewerID': [], 'EntID': [], 'Date': [], 'Activity': []})
for i in range(into):
    df = df.append({'ID': '%.12g' % i, 'ViewerID': '%.12g' % rnd.randint(0, viewers),
                    'EntID': '%.12g' % rnd.randint(0, entertainments), 'Date': rnd.choice(result),
                    'Activity': '%.12g' % rnd.randint(0, 1)},
                   ignore_index=True)

df.to_csv("into.csv", index=False)'''
