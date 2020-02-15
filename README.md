# 进度条

## 安装

```shell script
eeui plugin install https://github.com/aipaw/eeui-plugin-seekbar
```

## 卸载

```shell script
eeui plugin uninstall https://github.com/aipaw/eeui-plugin-seekbar
```

### 组件 eeuiSeekbar 属性

| 属性 | 作用 |
| --- | --- |
| color | 颜色 |
| progress | 进度 |
| max | 最大值 |
| min | 最小值 |

### 事件

| 名称 | 触发时机 |
| --- | --- |
| start | 开始执行拖拽时触发 |
| stop | 结束执行拖拽时触发 |
| change | 进度发生改变触发 |

### 方法

| 属性 | 作用 |
| --- | --- |
| setProgress(progress) | 设置进度 |

### demo

```
<template>
    <div style="align-items: center">
        <eeuiSeekbar ref="seek" :max="total" @change="change" class="seek" color="#ff0000"></eeuiSeekbar>
        <text style="font-size:24px">{{progress}}-{{total}}</text>
        <button class="button" text="手动设置 5000" @click="set"></button>
    </div>
</template>
<script>
    export default{
        data(){
            return {
                total:10000,
                progress:0,
            }
        },
        methods: {
            change(m){
                this.progress = m.value;
            },

            set() {
                this.$refs.seek.setProgress(5000);
            }
        }
    }
</script>
<style scoped>
    .seek {
        width:600px;
        height:100px;
    }
    .button {
        font-size: 24px;
        margin-top: 36px;
        width: 220px;
        height: 68px;
    }
</style>

```
