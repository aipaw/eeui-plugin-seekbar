package eeui.android.seekbar.entry;

import android.content.Context;

import com.taobao.weex.WXSDKEngine;
import com.taobao.weex.common.WXException;

import app.eeui.framework.extend.annotation.ModuleEntry;
import eeui.android.seekbar.component.AppSeekBar;

@ModuleEntry
public class seekbarEntry {

    /**
     * APP启动会运行此函数方法
     * @param content Application
     */
    public void init(Context content) {

        try {
            WXSDKEngine.registerComponent("eeuiSeekbar", AppSeekBar.class);
        } catch (WXException e) {
            e.printStackTrace();
        }
    }

}
