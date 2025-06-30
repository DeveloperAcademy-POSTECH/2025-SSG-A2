
> [!question]
>  GQ1. Core Motion의 기능 종류는 뭐가 있을까?
> GQ2. 어떤 방식으로 데이터를 수집할까?
## **Description**
### **Definition**
**Core Motion이란?**
- 아이폰, 애플워치, 에어팟 등 Apple 기기 속 다양한 센서(가속도계, 자이로스코프, 자기계, 기압계 등)에서 움직임 데이터를 받아, 앱이나 서비스에서 기기의 동작과 사용자의 활동을 인식할 수 있게 해주는 핵심 기술

**Core Motion 기본 센서 종류**
- 가속도계(Accelerometer): x, y, z 공간에서의 기기의 가속도 측정 (중력 포함)
- 자이로스코프(Gyroscope): 기기의 3차원 공간에서의 회전 계산
- 자기계(Magnetometer): 나침반 기능, 방향 감지 시 사용
- 기압계(Barometer): 공기 압력, 고도 변화 감지
- 만보기(Pedometer): 사용자 걸음 수, 계단 오르내림 정보

**데이터 처리 방식**
- 기본적으로 센서에서 수집하는 모든 데이터는 원시 값임 -> 자체적인 가공이 필요함.
- x, y, z 축의 가속도, 회전 등만 계산하는게 아니라 중력이 포함되기 때문에 데이터의 정제 후 사용해야 함.
- **가공 데이터**: 중력 보정, 사용자 가속도 분리 등 처리된 정보 (Device Motion) 중력이나 노이즈 등을 보정해서 실제로 '사용하기 쉬운' 형태로 만든 데이터입니다.
	- **예시**: 기기의 방향(roll, pitch, yaw), 중력 분리된 가속도, 사용자의 실제 움직임만 추출한 값 등.
    - **활용**: 흔들기 감지, 방향 변화, 활동 인식 등 대부분의 서비스에서는 이 가공 데이터를 더 많이 사용합니다. Core Motion이 내부적으로 여러 센서 데이터를 융합(fusion)해서 제공합니다.
### **Syntax**

```swift
let motionManager = CMMotionManager() 
motionManager.accelerometerUpdateInterval = 0.1

//Accelerometer 활용 로직
motionManager.startAccelerometerUpdates(to: .main) { data, error in 
	guard let acceleration = data?.acceleration else { return } 
	let x = acceleration.x 
	let y = acceleration.y 
	let z = acceleration.z
```
- CMMotionManager로 모션 센서 데이터 수집의 관리를 진행함.
- C언어의 malloc, free 처럼 stopAccelerometerUpdates()을 해줘야만 함 -> 안 할 경우 지속 데이터 수집으로 메모리 누수

## **주요 기능**
**Core Motion 기능 목록**

1. Essentials (기본 센서 관리) : 센서 켜기/끄기, 업데이트 설정 등 시스템 제어용 (개발용)
   
2. **Device Motion (자세·방향 인식) :** 기울기, 회전, 중력 방향
	- 운동 자세 체크, AR 게임/콘텐츠, 핸드폰 흔들기 제스처

3. **Accelerometer (가속도계) :** 흔들기, 진동, 낙하 감지
	- 걸음 수 측정, 스쿼트·푸쉬업 같은 운동 횟수 측정, 휴대폰 흔들기 인식

4. **Gyroscope (회전 속도 측정) :** 빠른 회전, 방향 전환
	- 게임 조작 (핸들 돌리기, 시점 전환), 스포츠 동작 분석 (예: 골프 스윙), VR 콘텐츠

5. **Magnetometer (자기계 / 방향 감지 / 나침반) :** 나침반, 북쪽 감지, 방향 인식
	- 나침반/지도 방향 표시, AR에서 방향 맞추기, 별자리 찾기 앱

6. **Altitude data (기압계 / 고도 변화 추적) :** 계단 오르기, 등산, 높이 변화
	- 등산 고도 기록, 계단 몇 층 올랐는지 측정, 층수 기반 칼로리 계산등 높이에 관한 것들..

7. **Ambient Pressure (대기압 측정) :** 공기 압력, 고도 보정
	- 날씨 변화 감지, 두통이나 컨디션 영향 파악, 실내/실외 구분

8. **Activity Recognition (사용자 활동 감지) :** 걷기/뛰기/차량 탑승 자동 분류
	- 걷는 중/차 타는 중 자동 인식, 운동 자동 기록, 앉아있는 시간 감지

9. **Water Submersion (침수 상태 감지) :** 물에 빠짐 감지, 방수 상태 확인
	- 기기가 물에 빠졌는지 확인, 수영할 때 앱 전환, 방수 상태 체크

10. **Activity (활동 상태 이벤트 처리) :** 활동 변화 알림, 이벤트 감지
	- 특정 행동 시 이벤트 트리거(ex산책 시작하면 음악 자동 재생), 운동 시작/종료 감지, 일상 리듬 파악

11. **Pedometer and Fitness (만보기 / 걸음/운동량 측정) :** 걸음 수, 거리, 칼로리
	- 하루 걸음 수 기록, 운동량 계산, 칼로리 소모량 추적

12. **Fall Detection (낙상 감지) :** 넘어짐 감지, 긴급 알림
	- 노약자 낙상 감지, 넘어졌을 때 보호자에게 알림, 응급 상황 대응

13. Historical Data (과거 모션 기록 조회) : 과거 기록 분석용 (분석용)
    
14. Common Data (공통 데이터/오류 처리) : 에러, 시간 정보 등 시스템 내부 처리 (분석용)
## **코드 예시**
**Accelerometer, GyroScope를 이용한 흔들기 횟수, 화면 기울임 감지 코드**
``` swift
import SwiftUI
import CoreMotion

struct JoidCoreMotion: View {
    @State private var rotationRate: CMRotationRate = .init()
    @State private var offset: CGSize = .zero
    @State private var isStarted: Bool = false
    @State private var shakeCount = 0
    @State private var isShaking = false
    private let motionManager = CMMotionManager()

    var body: some View {
        VStack {
            Color.blue.opacity(0.1).ignoresSafeArea()
            Text("Shake Count: \(shakeCount)")
                .font(.largeTitle)
                .padding()
            VStack{
                Button(isShaking ? "멈추기" : "측정 시작") {
                    if isShaking {
                        motionManager.stopAccelerometerUpdates()
                    } else{
                        startDetectingShakes()
                    }
                    isShaking.toggle()
                }

                Button("횟수 초기화"){
                    shakeCount = 0
                }
            }
        }

        ZStack {
            Color.blue.opacity(0.1).ignoresSafeArea()
            VStack {
                Text("Gyroscope")
                    .font(.title)
                Text("x: \(rotationRate.x, specifier: "%.2f")")
                Text("y: \(rotationRate.y, specifier: "%.2f")")
                Text("z: \(rotationRate.z, specifier: "%.2f")")
            }

            VStack{
                Circle()
                    .fill(Color.blue)
                    .frame(width: 60, height: 60)
                    .offset(offset)
                    .animation(.easeOut(duration: 0.1), value: offset)
                VStack {
                    Spacer()
                    Button(isStarted ? "모션 중지" : "모션 시작") {
                        if isStarted {
                            motionManager.stopDeviceMotionUpdates()
                            motionManager.stopGyroUpdates()
                        } else{
                            startMotionUpdates()
                            startGyroUpdates()
                        }
                        isStarted.toggle()
                    }
                    .padding()
                }
            }
            .padding(.top, 40)
        }
    }

    private func startDetectingShakes() {
        guard motionManager.isAccelerometerAvailable else { return }

        motionManager.accelerometerUpdateInterval = 0.2
        motionManager.startAccelerometerUpdates(to: .main) { data, error in
            guard let acceleration = data?.acceleration else { return }

            let threshold = 2.0
            let magnitude = sqrt(acceleration.x * acceleration.x +
                                 acceleration.y * acceleration.y +
                                 acceleration.z * acceleration.z)

            if magnitude > threshold {
                shakeCount += 1
            }
        }
    }

    func startMotionUpdates() {
        guard motionManager.isDeviceMotionAvailable else { return }
        motionManager.deviceMotionUpdateInterval = 0.02
        motionManager.startDeviceMotionUpdates(to: .main) { motion, error in
            guard let gravity = motion?.gravity else { return }

            let x = gravity.x * 100
            let y = -gravity.y * 100
            offset = CGSize(width: x, height: y)
        }
    }

    private func startGyroUpdates() {
            guard motionManager.isGyroAvailable else { return }
            motionManager.gyroUpdateInterval = 0.2
            motionManager.startGyroUpdates(to: .main) { data, error in
                guard let gyroData = data else { return }
                rotationRate = gyroData.rotationRate
            }
        }
}
```

## **Keywords**
- [[Accelerometer]]
- [[GyroScope]]
## **References**

- [Core Motion 공식 문서](https://developer.apple.com/documentation/coremotion/)
- [블로그](https://nsios.tistory.com/198)
- ChatGPT