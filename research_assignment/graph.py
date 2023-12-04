import matplotlib.pyplot as plt
#data
teams1=[1,2,3,4]
goals1=[20, 35, 25, 30]
teams2=[5,6,7,8]
goals2=[15, 28, 22, 18]

# Create bar chart
plt.bar(teams1, goals1, label='Group1')
plt.bar(teams2, goals2, label='Group2')
plt.xlabel('Teams')
plt.ylabel('Total Gols')
plt.title('Comparing Goals')
plt.legend()
plt.show()