from tkinter import *
import pandas as pd

cities_data = pd.read_csv('worldcities.csv')

background_color = 'grey'

cities_data = cities_data.dropna(subset='population')
cities_data = cities_data.sort_values('population', ascending=False)
cities_data['index'] = [i for i in range(1, len(cities_data)+1)]
cities_data['population'] = cities_data['population'].astype(int)

root = Tk()
root.geometry('500x400')
root.title('City Info')
root.config(background=background_color, )
root.resizable(False, False)

label_title = Label(root, text='City info', font=('Times New Roman', 16, 'bold italic'), bg=background_color)
label_title.place(x=205, y=0)

label_city = Label(root, text='City', bg=background_color, font=('Times New Roman', 13, 'bold italic'))
label_city.place(x=0, y=25)

entry_city = Entry(root, width=55)
entry_city.place(x=35, y=28)

def fun():
    global label_result_cit
    global label_result_index
    global label_result_country
    global label_result_city
    global enter_which_one

    city = entry_city.get().title()

    cit = cities_data.loc[cities_data['city'] == city]

    x = 0
    y = 70

    if not cit.empty and city == cit['city'].iloc[0]:
        label_full_result = Label(root, text=f'Here we have {len(cit)} result which one do you want me to bring out?', bg=background_color,
                                  font=('Times New Roman', 8, 'bold italic'))
        label_full_result.place(x=x, y=50)

        enter_which_one = Entry(root, width=10)
        enter_which_one.place(x=300, y=50)

        def num():
            global enter_which_one

            label_result_city = Label(root, text=cit['city'].values[int(enter_which_one.get()) - 1],
                                      bg=background_color, font=('Times New Roman', 8, 'bold italic'))
            label_result_city.place(x=35, y=y)

            label_result_index = Label(root, text=cit['index'].values[int(enter_which_one.get()) - 1],
                                       bg=background_color, font=('Times New Roman', 8, 'bold italic'))
            label_result_index.place(x=x, y=y)

            label_result_country = Label(root, text=cit['country'].values[int(enter_which_one.get()) - 1],
                                         bg=background_color, font=('Times New Roman', 8, 'bold italic'))
            label_result_country.place(x=120, y=y)

            enter_which_one = Entry(root, width=10)
            enter_which_one.place(x=300, y=50)

        submit_num = Button(root, text='Submit', bg=background_color, font=('Times New Roman', 7, 'bold italic'),
                                width=10, command=num)
        submit_num.place(x=371, y=50)

    else:
        label_result_cit = Label(root, text='Sorry but this city not found', bg=background_color,
                                 font=('Times New Roman', 8, 'bold italic'))
        label_result_cit.place(x=0, y=50)


    def close():
        try:
            label_result_index.destroy()
            label_result_country.destroy()
            label_result_city.destroy()
            label_result_cit.destroy()
        except:
            pass

    close_button = Button(root, text="Close", bg=background_color, font=('Times New Roman', 7, 'bold italic'),
                                  width=10, command=close)
    close_button.place(x=0, y=200)

submit_city = Button(root, text="Submit", bg=background_color, font=('Times New Roman', 7, 'bold italic'), width=10, command=fun)
submit_city.place(x=371, y=27)

root.mainloop()
