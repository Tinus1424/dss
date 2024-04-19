def sort_images(image_dictionary):
    dictcopy = image_dictionary.copy()
    listdict = list(dictcopy.items())
    listdict.sort(key = lambda x: x[1])
    dictdict = dict(listdict)
    return dictdict #dict

mri_image_data = {
    'brain1.jpg': 120,
    'brain2.png': 90,
    'brain3.jpeg': 150,
    'brain4.gif': 75,
    'brain5.png': 200
}
print(sort_images(mri_image_data))