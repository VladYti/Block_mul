from matplotlib.backends.backend_pdf import PdfPages
import matplotlib.pyplot as plt
import numpy as np


def read_from(f_name: str, k: int, n: int) -> dict:
    with open(f_name, 'r') as f:
        ls = f.readlines()
    d = {}
    ind = int((len(ls) - k) / k)
    for i in range(k):
        if i != 0:
            d[int(n / (2 ** i))] = ls[0 + (ind + 1) * i:ind + (ind + 1) * i]
        else:
            d[0] = ls[0 + (ind + 1) * i:ind + (ind + 1) * i]

    dd = {}
    for key in d.keys():
        dd[key] = list(map(lambda x: float(x.strip()[:-2]), d[key]))

    average = {}
    for key in dd.keys():
        average[key] = round(sum(dd[key]) / len(dd[key]), 4)

    return average


def main():

    value_512 = read_from('time_512.txt', 9, 512)
    value_1024 = read_from('time_1024.txt', 9, 1024)
    value_2048 = read_from('time_2048.txt', 10, 2048)
    value_4096 = read_from('time_4096.txt', 10, 4096)
    value_8192 = read_from('time_8192.txt', 10, 8192)


    value_512[512] = value_512.pop(0)
    value_1024[1024] = value_1024.pop(0)
    value_2048[2048] = value_2048.pop(0)
    value_4096[4096] = value_4096.pop(0)
    value_8192[8192] = value_8192.pop(0)


    # means = {'512': tuple(dict(sorted(value_512.items())).values())}
    # print(means)

    values=[]
    vals = [value_512, value_1024, value_2048, value_4096]
    for item in vals:
        for i in range(1, 13):
            if 2**i in item:
                continue
            else:
                item[2**i] = 0
        values.append(dict(sorted(item.items())))



    species = tuple(map(str,dict(sorted(values[0].items())).keys()))
    print(species)

    means = {}
    for ind, item in enumerate(values):
        print(ind)
        means[2**(9+ind)] = tuple(dict(sorted(item.items())).values())
    print(means)




    x = np.arange(len(species))*10
    width = 1.5 # the width of the bars
    multiplier = 0

    font = {'family': 'serif',
            'color': 'darkred',
            'weight': 'normal',
            'size': 16,
            }

    fig, ax = plt.subplots(constrained_layout=True)
    for attribute, measurement in means.items():
        offset = width * multiplier
        rects = ax.bar(x + offset, measurement, width, label=attribute)
        # ax.bar_label(rects, padding=4)
        multiplier += 1

    ax.set_yscale('log')
    ax.set_ylabel('Time (sec)', fontdict=font)
    ax.set_xlabel('Elements per block', fontdict=font)
    ax.set_title('Comparison of results', fontdict=font)
    ax.set_xticks(x+width, species)
    ax.legend(loc='upper left', ncols=5)
    ax.set_ylim(0,300)


    figures = [fig]

    pdf = PdfPages("fig0.pdf")
    for figure in figures:
        pdf.savefig(figure)
    pdf.close()

    # font = {'family': 'serif',
    #         'color': 'darkred',
    #         'weight': 'normal',
    #         'size': 16,
    #         }
    #
    # d = dict(sorted(value_4096.items()))
    # mx = d.pop(4096)
    # x = np.arange(len(d.keys())) * 10
    # fig, ax = plt.subplots()
    # ax.plot(x, d.values(), 'b.-', x, [mx]*len(d.keys()), 'r')
    # ax.set_xticks(x, d.keys())
    # ax.set_xlabel('Elements per block', fontdict=font)
    # ax.set_ylabel('Time (sec)', fontdict=font)
    # ax.legend(['block mul', 'std mul'], loc='upper right', ncols=5)
    # ax.text(5, 30, str(mx), fontsize=12)
    # ax.text(35, 6, str(d[128]), fontsize=12)
    # ax.set_title('Matrix 4096x4096', fontsize=20)
    # plt.grid(True)
    # plt.show()
    # figures = [fig]
    #
    # pdf = PdfPages("fig6.pdf")
    # for figure in figures:
    #     pdf.savefig(figure)
    # pdf.close()


    return 0


if __name__ == '__main__':
    main()
