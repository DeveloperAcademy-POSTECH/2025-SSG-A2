
> [!question]
> 
> **GQ1. CMDeviceMotion은 어떤 데이터를 제공할까?**
> **GQ2. 왜 Accelerometer나 Gyroscope 대신 이걸 쓸까?**
## **Description**
### **Definition**
**CMDeviceMotion이란?**

- Core Motion에서 제공하는 고수준 모션 데이터 타입
- 가속도계, 자이로스코프, 자기계, 중력 센서 등을 융합(fusion)하여 만든 정제된 가공 데이터
- 흔들림, 회전, 기울기, 방향 등 **기기 자세와 움직임을 더 정확하게** 측정할 수 있음
- CMMotionManager를 통해 사용

**사용 이유**
- 센서 원시 데이터(accelerometer, gyroscope)는 노이즈가 많고 처리 복잡
- CMDeviceMotion은 Core Motion이 자동으로 중력 제거, 필터링, 센서 융합해줌
  -> 따라서 실제 앱에서는 대부분 이 데이터를 사용

### 주요 기능
- **attitude**
  기기의 공간상 회전 상태를 나타내는 속성으로, roll, pitch, yaw 세 가지 축의 회전 값을 제공한다. 이를 통해 사용자가 기기를 어떤 방향으로 기울였는지, 또는 어떤 자세로 들고 있는지를 정확하게 파악할 수 있다.
- **gravity**
  기기에 작용하는 중력 벡터(x, y, z)를 나타낸다. 전체 가속도에서 중력 성분만을 분리하여 제공하며, 기기의 방향 판단이나 중력 보정을 포함한 계산에 활용된다.
- **userAcceleration**
  중력 요소를 제거한 사용자의 실제 움직임에 의한 가속도이다. 사용자가 손으로 기기를 흔드는 등 **의도된 동작**만을 추출할 수 있어, 흔들기 감지나 모션 기반 인터랙션 구현에 적합하다.
- **rotationRate**
  자이로스코프를 기반으로 측정된 각속도(angular velocity)로, 초당 회전 속도를 나타낸다. 기기의 회전 방향이나 회전 강도를 감지할 수 있으며, 빠른 회전이 감지될수록 이 값이 커진다.
- **magneticField**
  자기계(Magnetometer)를 통해 측정된 자기장 정보로, 방향 감지 또는 나침반 기능 구현에 활용된다. 자기장 세기뿐 아니라 해당 데이터의 정확도도 함께 제공된다.
- **heading**
  북쪽을 기준으로 한 기기의 방향 정보를 의미한다. 단, 이 속성은 모든 상황에서 자동으로 제공되지는 않으며, 특정 모드에서 활성화해야 사용할 수 있다. 주로 나침반 또는 방향 기반 기능 구현 시 사용된다.

### **활용 예시**
- 기기 방향 추적 (AR, 게임 조작, 나침반 등)
- 운동 동작 인식 (스쿼트, 팔 굽혀펴기 등)
- 중력 보정된 움직임 기반 애니메이션
- 흔들기, 기울이기 기반 인터랙션

### 예시 코드

```swift
let motionManager = CMMotionManager()

if motionManager.isDeviceMotionAvailable {
    motionManager.deviceMotionUpdateInterval = 0.02
    motionManager.startDeviceMotionUpdates(to: .main) { data, error in
        guard let motion = data else { return }

        // 자세 정보
        let roll = motion.attitude.roll
        let pitch = motion.attitude.pitch
        let yaw = motion.attitude.yaw

        // 중력 벡터
        let gravity = motion.gravity

        // 사용자의 실제 움직임 (중력 제거된 값)
        let userAccel = motion.userAcceleration

        // 자이로 회전 속도
        let rotation = motion.rotationRate
    }
}
```

## **Keywords**
- [[CMDeviceMotion]]
- [[Attitude (roll, pitch, yaw)]]
- [[Gravity / User Acceleration]]
- [[Sensor Fusion]]

## **References**
- [Apple Docs – CMDeviceMotion](https://developer.apple.com/documentation/coremotion/cmdevicemotion)
- [MotionKit Sensor Fusion](https://medium.com/ios-os-x-development/motionkit-the-missing-ios-coremotion-wrapper-written-in-swift-99fcb83355d0)
- ChatGPT