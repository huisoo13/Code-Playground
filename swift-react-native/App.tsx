/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 *
 * @format
 */

import React from 'react';
import type {PropsWithChildren} from 'react';
import {
    ScrollView,
    StatusBar,
    StyleSheet,
    Text,
    useColorScheme,
    View,
    Button,
    NativeModules,
    Alert
} from 'react-native';

import {
    Colors,
    DebugInstructions,
    Header,
    ReloadInstructions,
} from 'react-native/Libraries/NewAppScreen';

function App(props): React.JSX.Element {
    const isDarkMode = useColorScheme() === 'dark';
    
    const backgroundStyle = {
        backgroundColor: isDarkMode ? Colors.darker : Colors.lighter,
    };
    
    const { CallbackManager } = NativeModules;
    
    const handleButtonPress = async () => {
        try {
            console.log('Swift의 executeCallback 함수를 호출합니다.');
            
            // 1. Swift 함수를 호출하고, Swift에서 resolve를 호출할 때까지 기다립니다.
            const result = await CallbackManager.executeCallback('나는 눌렀다.');
            
            // 2. Swift에서 전달한 결과(resultMessage)를 알림창으로 띄웁니다.
            Alert.alert('Swift로부터 온 응답', result);
            
        } catch (error) {
            // Swift에서 reject를 호출하면 이쪽으로 빠집니다.
            console.error(error);
        }
    };
    
    return (
        <View>
            <Text style={styles.title}>UserID: {props.userID}</Text>
            <Text style={styles.title}>Token: {props.token}</Text>
            <Button
                title="Swift에 콜백 보내기"
                onPress={handleButtonPress} // 버튼 누르면 함수 실행
            />
        </View>
    );
}

const styles = StyleSheet.create({
    title: {
        fontSize: 24,
        fontWeight: '600',
        marginLeft: 20,
    },
    bold: {
        fontWeight: '700',
    },
});

export default App;
