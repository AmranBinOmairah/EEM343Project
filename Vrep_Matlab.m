close all 
clear all
clc
sim=remApi('remoteApi'); % using the prototype file (remoteApiProto.m)
sim.simxFinish(-1); % just in case, close all opened connections
clientID=sim.simxStart('127.0.0.1',19999,true,true,5000,5);




if (clientID>-1)
    disp('Connected to remote API server');
    
    [r,jointhandle1]=sim.simxGetObjectHandle(clientID,'UR5_joint1',sim.simx_opmode_blocking);
    [r,jointhandle2]=sim.simxGetObjectHandle(clientID,'UR5_joint2',sim.simx_opmode_blocking);
    [r,jointhandle3]=sim.simxGetObjectHandle(clientID,'UR5_joint3',sim.simx_opmode_blocking);
    [r,jointhandle4]=sim.simxGetObjectHandle(clientID,'UR5_joint4',sim.simx_opmode_blocking);
    [r,jointhandle5]=sim.simxGetObjectHandle(clientID,'UR5_joint5',sim.simx_opmode_blocking);
    [r,jointhandle6]=sim.simxGetObjectHandle(clientID,'UR5_joint6',sim.simx_opmode_blocking);
    [r,Connector]=sim.simxGetObjectHandle(clientID,'BarrettHand_attachPoint',sim.simx_opmode_blocking);
    [r,Proximity_sensor]=sim.simxGetObjectHandle(clientID,'BarrettHand_attachProxSensor',sim.simx_opmode_blocking);
    [r,platform]=sim.simxGetObjectHandle(clientID,'OmniPlatform',sim.simx_opmode_blocking);

    vel=180;
    accel=40;
    jerk=80;
    maxVel={vel*pi/180,vel*pi/180,vel*pi/180,vel*pi/180,vel*pi/180,vel*pi/180};
    maxAccel={accel*pi/180,accel*pi/180,accel*pi/180,accel*pi/180,accel*pi/180,accel*pi/180;}
    maxJerk={jerk*pi/180,jerk*pi/180,jerk*pi/180,jerk*pi/180,jerk*pi/180,jerk*pi/180};
    
    targetPos1={43.95*pi/180,-22.25*pi/180,98.11*pi/180,-75.88*pi/180,-43.95*pi/180,0.039*pi/180};
    moveToConfig(jointHandles,maxVel,maxAccel,maxJerk,targetPos1)
    targetPos2={66.14*pi/180,8.67*pi/180,71.14*pi/180,-79.84*pi/180,-66.14*pi/180,0.036*pi/180};
    moveToConfig(jointHandles,maxVel,maxAccel,maxJerk,targetPos2)
    [result,detectionState,detectedPoint,detectedObjectHandle,detectedSurfaceNormalVector]=sim.simxReadProximitySensor(clientID,Proximtiy_sensor,sim.simx_opmode_streaming)
    %set parent
    [returnCode]=sim.simxSetObjectParent(clientID,detectedObjectHandle,Connector,true,sim.simx_opmode_oneshot);
    targetPos3={43.95*pi/180,-22.25*pi/180,98.11*pi/180,-75.88*pi/180,-43.95*pi/180,0.039*pi/180};
    moveToConfig(jointHandles,maxVel,maxAccel,maxJerk,targetPos3)
    targetPos4={-92.34*pi/180,14.87*pi/180,80.93*pi/180,-6.61*pi/180,-89.19*pi/180,-92.11*pi/180};
    moveToConfig(jointHandles,maxVel,maxAccel,maxJerk,targetPos4)
    %set parentless
    [returnCode]=sim.simxSetObjectParent(clientID,detectedObjectHandle,-1,true,sim.simx_opmode_oneshot);
    targetPos5={39.46*pi/180,29.11*pi/180,76.64*pi/180,-105.81*pi/180,-39.46*pi/180,0.041*pi/180};
    moveToConfig(jointHandles,maxVel,maxAccel,maxJerk,targetPos5)
    [result,detectionState,detectedPoint,detectedObjectHandle,detectedSurfaceNormalVector]=sim.simxReadProximitySensor(clientID,Proximtiy_sensor,sim.simx_opmode_streaming)
    %set parent
    [returnCode]=sim.simxSetObjectParent(clientID,detectedObjectHandle,Connector,true,sim.simx_opmode_oneshot);
    targetPos6={13.73*pi/180,0*pi/180,105.42*pi/180,-113.61*pi/180,-13.73*pi/180,0.096*pi/180};
    moveToConfig(jointHandles,maxVel,maxAccel,maxJerk,targetPos6)
    targetPos7={-92.34*pi/180,14.87*pi/180,80.93*pi/180,-6.61*pi/180,-89.19*pi/180,-92.11*pi/180};
    moveToConfig(jointHandles,maxVel,maxAccel,maxJerk,targetPos7)
     %set parentless
    [returnCode]=sim.simxSetObjectParent(clientID,detectedObjectHandle,-1,true,sim.simx_opmode_oneshot);
    targetPos0={0,0,0,0,0,0};
    moveToConfig(jointHandles,maxVel,maxAccel,maxJerk,targetPos0)
    [result,detectionState,detectedPoint,detectedObjectHandle,detectedSurfaceNormalVector]=sim.simxReadProximitySensor(clientID,Proximtiy_sensor,sim.simx_opmode_streaming)
    %set parent
    [returnCode]=sim.simxSetObjectParent(clientID,detectedObjectHandle,Connector,true,sim.simx_opmode_oneshot);
    
    %set parentless
    [returnCode]=sim.simxSetObjectParent(clientID,detectedObjectHandle,-1,true,sim.simx_opmode_oneshot);
    
    
    
    function moveToConfig(handles,maxVel,maxAccel,maxJerk,targetConf)
    
    [ret,currentConf1]=sim.simxGetJointPosition(clientID,jointhandle1,sim.simx_opmode_streaming);
    [ret,currentConf2]=sim.simxGetJointPosition(clientID,jointhandle2,sim.simx_opmode_streaming);
    [ret,currentConf3]=sim.simxGetJointPosition(clientID,jointhandle3,sim.simx_opmode_streaming);
    [ret,currentConf4]=sim.simxGetJointPosition(clientID,jointhandle4,sim.simx_opmode_streaming);
    [ret,currentConf5]=sim.simxGetJointPosition(clientID,jointhandle5,sim.simx_opmode_streaming);
    [ret,currentConf6]=sim.simxGetJointPosition(clientID,jointhandle6,sim.simx_opmode_streaming);

    %sim.moveToConfig(-1,currentConf,nil,nil,maxVel,maxAccel,maxJerk,targetConf,nil,movCallback,handles)
    
end
else 
    disp('Failed connecting to remote API server');
end
    sim.delete(); % call the destructor!
    
    disp('Program ended');