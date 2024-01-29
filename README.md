# SUSTech-CS207-Project-Piano（2023fall Digital Logic）
### bonus视频介绍和代码讲解上传到b站了，约13分钟
【链接跳转】(https://www.bilibili.com/video/BV1u4421A7pW/?vd_source=2347c699c40e3a971470bde33b0f40de)

## 介绍
这是南方科技大学大二上的数字逻辑课程的一个写好的项目（在分数显示上有bug，开学拿到开发板后修改），代码利用fpga开发板实现了一个可以自由弹奏、自动播放歌曲并且有学习模式——超低配版的音游和切换按键模式——根据用户喜好选择不同音符对应不同开关的电子钢琴。项目由两人合作完成，得分104/100。使用verilog语言，vivado 2017.4编程，利用VScode辅助编程。由于vivado无法自动补充语法和标亮begin end，加上VScode里有很多好用的插件——例如Copilot支持自动补充无脑代码，建议编程时可以多用用VScode。项目的代码目前还未经过框架化和优化，因此包含较多单纯重复的屎山成分，后期会抽时间修改QAQ。
## 如何让代码在板子上跑起来
首先，你要有一块开发板。自己买会很贵（两三千块左右），可以直接找学校老师借，大部分计算机系应该都配有类似的开发板。我们使用的是XILINX的型号为xc7a35tcsg324-1的开发板，如图。

[![1.jpg](https://i.postimg.cc/qvmNSWk9/1.jpg)](https://postimg.cc/ZWdYy7vc)

然后把src目录里的design目录下的所有.v文件直接复制到vivado项目的design sources根目录下，再把src目录里的constraint目录下的.xdc文件复制到vivado项目的Constraints根目录下，run synthesis、run implementation，最后生成比特流即可。注意，硬件型号需要选择xc7a35tcsg324-1，如果没有该开发板需要自行根据自己开发板的用户手册微调.xdc文件内容。

## 成功烧写代码后如何使用电子琴
详情请看视频介绍
#### [视频链接]https://www.bilibili.com/video/BV1u4421A7pW/?vd_source=2347c699c40e3a971470bde33b0f40de

## 项目报告
### Team Roles and Schedule
#### Contribution Ratio: 1:1

**Wang Zhiya:**
- 7-segment display
- Song encoding
- Constraint file
- Testing for pitch and duration

**Chen Jinyue:**
- LED
- Logic for four music modes
- Integration

#### Planned Schedule:

- **Week 12:**
  - Team discussion
  - Understanding project framework and requirements

- **Week 13:**
  - Implement basic project functionalities
  - Complete single module simulation

- **Week 14:**
  - Implement project bonuses
  - Complete single module simulation

- **Week 15:**
  - Integration
  - On-board testing and debugging
  - Documentation writing
  - Video recording

#### Progress Update:

During the actual implementation, we conducted on-board testing for individual modules ahead of schedule. We performed simulations concurrently with on-board testing, avoiding the strategy of waiting for all single modules to be simulated successfully before initiating on-board testing. This approach was chosen to address potential issues promptly.

### System Function List

[![2.png](https://i.postimg.cc/VNpzPdYn/2.png)](https://postimg.cc/bGx7QYSw)

[![3.png](https://i.postimg.cc/tgY9chH9/3.png)](https://postimg.cc/5HWcYQ0r)

[![4.png](https://i.postimg.cc/x1jfKwxJ/4.png)](https://postimg.cc/w7PYzGdg)

### Top module introduction

[![5.png](https://i.postimg.cc/HLndcbSf/5.png)](https://postimg.cc/QF2RvKZb)

[![6.png](https://i.postimg.cc/90MGs81L/6.png)](https://postimg.cc/S2B2MGB9)

#### Input

- **baDu:** Two buttons for adjusting the octave level (low, middle, high). Default is set to low octave.
- **touch:** Corresponding to eight switches, representing user keystrokes.
- **choice:** Three switches representing song numbers for song selection.
- **mode:** Two switches for toggling between free/automatic playback/learning/switching button modes.
- **clk, rst:** System clock and system reset signal.
- **user:** Three switches indicating user preferences.

#### Output

- **Led:** LEDs above the eight switches, used to illuminate when the corresponding note is played.
- **Led_length:** Four LEDs on the right side, the number of lit LEDs represents the standard length of the note.
- **tub_control1, 2:** Left and right seven-segment displays.
- **tub_sel:** Used to control whether the eight seven-segment displays light up.
- **t:** System variable.

### Introduction to Single Module Functionalities
## Free Mode
In this mode, users generate sounds corresponding to pressed keys, accompanied by the illumination of corresponding LEDs. Two octave buttons are provided to adjust the octave, with the default set to low. "AnJian" is utilized to indicate the input signal for each key on the keyboard.

## Auto Mode
In automatic playback mode, the current song library includes three songs: "Twinkle, Twinkle, Little Star," "Qian Qian Que Ge," and "Ji Le Jing Tu." Users can select a song by pressing the keys corresponding to the song number. After playing a song, it automatically loops. Corresponding LEDs illuminate with each played note.

## Learning Mode
In the learning mode, the corresponding LED illuminates, and the sound is played for a given note. The timer starts when the user lifts the key to play the correct note. Upon lowering the key, the timer stops, and the LED corresponding to the next note illuminates, initiating the playback of the subsequent note. Real-time scoring occurs based on the difference between the standard duration and the user's played duration, resulting in an A-0-C score, which is added to the overall score. The standard duration is indicated by the number of illuminated LEDs on the right side. "Enable" is set to 1 when the user presses the correct key, and "SAB/score" represents the current note performance and overall performance of the user.

## Change Mode
In the button-switching mode, users can specify changing the key for one note each time. After pressing the confirmation key, they can choose to switch to the next note's key or stop the switching and exit the mode. "Note" indicates the desired note to be changed.

## Rank
Utilizing bubble sort, the scores of each user for every song are ranked. "LittleStar" and other three inputs record the highest scores of each user for each song. "highestScore" represents the current user's highest score for the current song.

## Led
LED illumination control, with "length" as the input representing the standard duration of a musical note.

## Lightseg Module

### Input:
- clk, reset: system clock and system reset (active high)
- [2:0] user: input user
- [2:0] order: input song number
- [1:0] mode: input mode
- [1:0] timedifference: input score for a single note
- [2:0] rank: input ranking

### Output:
- tub_sel1, tub_sel2, tub_sel3, tub_sel4, tub_sel5, tub_sel6, tub_sel7, tub_sel8: light up the digit from left to right
- [7:0] tub_control1, tub_control2: display content information for the left four digits and right four digits of the display respectively

### Functionality:
Control the light and display content of the display based on input signals. The displayed content of the display will change depending on the mode and input signals.

### Code Logic:
Specific functionality includes:

- **Free Mode (mode=00):** The leftmost digit displays the letter "F," and all other digits are turned off.
  
- **Auto Play Mode (mode=01):** The leftmost digit displays the corresponding number code according to the order input, and the rightmost digit displays the letter "A". All other digits are turned off.

- **Learning Mode (mode=10):** Control the display of the display based on the value of `scan_count`. When `scan_count` is 111, the leftmost digit displays the corresponding number code according to the user input; when `scan_count` is 110, the leftmost digit displays the corresponding number code according to the order input; when `scan_count` is 101, the leftmost digit displays the corresponding letters of "CBAS" according to the `timedifference` input; when `scan_count` is 100, the leftmost digit displays the corresponding number code according to the `rank` input. All other digits are turned off.

- **Key Adjustment Mode:** The display shows the letter "c," the rightmost digit is always on, and all other digits are turned off. This module also includes a clock divider and related registers and counters. By controlling the scanning and display of the display with a residual effect similar to that of a movie film, it can imitate the human eye's recognition of light and dark.

## XiaoDou2
Implements debouncing for all inputs. "Wrong" represents the signal before debouncing, while "right" represents the signal after debouncing.

## Counter/Divider
A clock tuner that allows for the customization of frequency. "tiaoPin" serves as the input signal for adjusting the frequency, while "clk_bps" is a signal indicating periodic changes at specific multiples, resulting in altered cycle durations.

## DFF
DFF, "Q" and "nQ" represent standard output signals, while "D" serves as the input signal.

## Buzzer
Based on the input "mode," a specific music selection is made. The transcoded output is then directed to "speaker" as the speaker signal.








































