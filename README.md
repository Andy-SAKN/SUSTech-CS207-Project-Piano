# SUSTech-CS207-Project-Piano（2023fall Digital Logic）
### bonus视频介绍和代码讲解上传到b站了，约13分钟
【链接跳转】https://www.bilibili.com/video/BV1u4421A7pW/?vd_source=2347c699c40e3a971470bde33b0f40de

## 介绍
这是南方科技大学大二上的数字逻辑课程的一个写好的项目（在分数显示上有bug，开学拿到开发板后修改），代码利用fpga开发板实现了一个可以自由弹奏、自动播放歌曲并且有学习模式——超低配版的音游和切换按键模式——根据用户喜好选择不同音符对应不同开关的电子钢琴。项目由两人合作完成，得分104/100。使用verilog语言，vivado 2017.4编程，利用VScode辅助编程。由于vivado无法自动补充语法和标亮begin end，加上VScode里有很多好用的插件——例如Copilot支持自动补充无脑代码，建议编程时可以多用用VScode。项目的代码目前还未经过框架化和优化，因此包含较多单纯重复的屎山成分，后期会抽时间修改QAQ。
## 如何让代码在板子上跑起来
首先，你要有一块开发板。自己买会很贵（两三千块左右），可以直接找学校老师借，大部分计算机系应该都配有类似的开发板。我们使用的是XILINX的型号为xc7a35tcsg324-1的开发板，如图。

[![1.jpg](https://i.postimg.cc/qvmNSWk9/1.jpg)](https://postimg.cc/ZWdYy7vc)

然后把src目录里的design目录下的所有.v文件直接复制到vivado项目的design sources根目录下，再把src目录里的constraint目录下的.xdc文件复制到vivado项目的Constraints根目录下，run synthesis、run implementation，最后生成比特流即可。注意，硬件型号需要选择xc7a35tcsg324-1，如果没有该开发板需要自行根据自己开发板的用户手册微调.xdc文件内容。

## 成功烧写代码后如何使用电子琴
详情请看视频介绍[视频链接]https://www.bilibili.com/video/BV1u4421A7pW/?vd_source=2347c699c40e3a971470bde33b0f40de

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






































