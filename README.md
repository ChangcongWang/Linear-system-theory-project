# 线性系统理论大作业
# Linear-system-theory-project
为2021年秋季学期山大线性系统理论7组大作业，若有不正确之处麻烦各位指正。
## PPT&PDF
正如其名，答辩时的PPT和PDF版汇报。
## Matlab代码
在Matlab中运行`code.m`文件获得参数，在simulink中打开`LSTsimulink.slx`,在`MPC Designer`中Open Session选择`MPCDesignerSession.mat`并点击`Update and Simulate`进行仿真就能出图像。也可以对权重、初始值、步长等参数进行调节。
## mpc-dog
mpc-dog为[Motion Imitation](https://github.com/ChangcongWang/Linear-system-theory-project)原代码删减而成，基本只保留了最小能够运行MPC控制四足机器人的代码。  

`cd .\mpc-dog\`并运行下述指令安装mpc_osqp包。
```
python setup.py install --user
```
简单讲下`locomotion_controller_example`几个关键参数。
| 参数              | 意义                                                                     |
| ----------------- | ------------------------------------------------------------------------ |
| _MAX_TIME_SECONDS | 运行时长                                                                 |
| speed_points      | 在该时间点需要达到的期望值，前3个为xyz方向上的速度，最后一个为期望偏航角 |

MPC部分主要在站立腿文件`torque_stance_leg_controller`中及`mpc_osqp.cc`，主要求解过程在`mpc_osqp.cc`中。`torque_stance_leg_controller`的_MPC_WEIGHTS即为权重Q
# 参考资料
除pdf中列举的参考文献外，还大量参考了知乎上twyang大佬的[专栏](https://www.zhihu.com/column/c_1279444167681593344)