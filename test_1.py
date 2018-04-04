

total = 8

list_in = [1, 2, 3, 6]



def remove_excrescent(list_in, total):
    sum = 0
    list_out = []
    for each_num in list_in:
        sum += each_num
        if sum <= total:
            list_out.append(each_num)
        elif sum > total:
            diff = sum - total
            list_out.append(each_num - diff)
    return list_out

print(list_in)

list_in = remove_excrescent(list_in, total)

print(list_in)
