import React, { useState, useEffect } from 'react';
import type { PropsWithChildren } from 'react';

import {
    StyleSheet,
    Text,
    View,
    Button,
    TouchableOpacity,
    NativeModules,
    NativeEventEmitter
} from 'react-native';

import {
    Colors,
    DebugInstructions,
    Header,
    ReloadInstructions,
} from 'react-native/Libraries/NewAppScreen';

function App(props): React.JSX.Element {
    
    const { ReactNativeModule } = NativeModules;
    const [count, setCount] = useState(0);

    useEffect(() => {
        const eventEmitter = new NativeEventEmitter(ReactNativeModule);
        
        // 3. 'onTimerTick' 이벤트를 구독합니다.
        //    이벤트가 발생할 때마다 전달받은 데이터(event)로 state를 업데이트합니다.
        const eventListener = eventEmitter.addListener('onTimerTick', (event) => {
            console.log('REACT NATIVE', 'onTimerTick', event.count);
            setCount(event.count);
        });
        
        // 4. 컴포넌트가 사라질 때 리스너를 정리합니다. (메모리 누수 방지)
        return () => {
            eventListener.remove();
        };
    }, []); // 빈 배열을 전달하여 컴포넌트가 처음 마운트될 때 한 번만 실행되도록 합니다.
    
    const handleStartTimer = () => {
        console.log("REACT NATIVE", 'START');
        ReactNativeModule.timer();
    };
    
    const handleCallback = async () => {
        try {
            console.log('REACT NATIVE', 'Callback');
            const result = await ReactNativeModule.callback("SEND")
            console.log('REACT NATIVE', result);
            
        } catch (error) {
            // Swift에서 reject를 호출하면 이쪽으로 빠집니다.
            console.error(error);
        }
    };

    
    return (
        <View style= { styles.container }>
            <Text style= { styles.title }>React native 호출 시 Native에서 전달한 값</Text>
            <Text style= { styles.description }>User ID: { props.userID }</Text>
            <View style={{ height: 8 }} />
            <Text style= { styles.description }>Token: { props.token }</Text>
            <View style={{ height: 16 }} />
            <View style= { styles.hStack }>
                <Text style= { styles.description }>Native에서 Timer 시작</Text>
                <TouchableOpacity onPress={ handleStartTimer }>
                    <Text style={ styles.button }>실행</Text>
                </TouchableOpacity>
            </View>
            <View style={{ height: 8 }} />
            <View style= { styles.hStack }>
                <Text style= { styles.description }>데이터 통신</Text>
                <TouchableOpacity onPress={ handleCallback }>
                    <Text style={ styles.button }>실행</Text>
                </TouchableOpacity>
            </View>
        </View>
    );
}

    const styles = StyleSheet.create({
        container: {
          padding: 16
        },
        title: {
            fontSize: 16,
            fontWeight: '600',
            marginBottom: 16,
        },
        description: {
            fontSize: 14,
            fontWeight: '400',
        },
        bold: {
            fontWeight: '700',
        },
        button: {
            fontSize: 14,
            fontWeight: '600',
            color: '#05F'
        },
        hStack: {
            flexDirection: 'row',            // 수평 정렬
            justifyContent: 'space-between', // 양쪽 끝 정렬 + 중간 여백
            alignItems: 'center',            // 수직 중앙 정렬
            padding: 16,
            borderWidth: 1,            // 테두리 두께
            borderColor: '#999',       // 테두리 색상
            borderRadius: 10,          // 둥근 모서리 반경
            backgroundColor: '#f9f9f9' // 배경색 (선택 사항)

        },
    });
                    
export default App;
