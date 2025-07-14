import { NativeEventEmitter, NativeModules } from 'react-native';

const { ReactNativeModule } = NativeModules;

const eventEmitter = new NativeEventEmitter(ReactNativeModule);

eventEmitter.addListener('call', (event) => {
    console.log('JavaScript:', event);
    handleEvent(event)
});

const handleEvent = async (event) => {
    try {
        switch (event.method) {
            case 'multiply':
//                const { method, a, b } = event;
                
//                const multiplicationResult = a * b;

//                console.log('JavaScript:', multiplicationResult);
//                console.log('JavaScript:', a * b);
                
                const result = await ReactNativeModule.callback("TEST")
                console.log('JavaScript:', result);

                break
            case 'test':
                break
            default:
                break
        }
    } catch (error) {
        console.error("ERROR")
    }
}

console.log('✅ 이벤트 리스너가 성공적으로 등록되었습니다.');
