package eeui.android.seekbar.component;

import android.content.Context;
import android.graphics.Color;
import android.graphics.PorterDuff;
import android.graphics.drawable.Drawable;
import android.graphics.drawable.LayerDrawable;
import android.os.Build;
import android.support.annotation.NonNull;
import android.view.Gravity;
import android.view.ViewGroup;
import android.widget.LinearLayout;
import android.widget.SeekBar;

import com.taobao.weex.WXSDKInstance;
import com.taobao.weex.annotation.JSMethod;
import com.taobao.weex.ui.action.BasicComponentData;
import com.taobao.weex.ui.component.WXComponent;
import com.taobao.weex.ui.component.WXComponentProp;
import com.taobao.weex.ui.component.WXVContainer;

import java.util.HashMap;
import java.util.Map;

public class AppSeekBar extends WXComponent<ViewGroup> {

    private SeekBar seekBar = null;

    public AppSeekBar(WXSDKInstance instance, WXVContainer parent, BasicComponentData basicComponentData) {
        super(instance, parent, basicComponentData);
    }

    @Override
    protected ViewGroup initComponentHostView(@NonNull Context context) {
        LinearLayout view = new LinearLayout(context);
        view.setOrientation(LinearLayout.VERTICAL);
        view.setPadding(8, 0, 8, 0);
        view.setGravity(Gravity.CENTER);
        seekBar = new SeekBar(context);
        seekBar.setOnSeekBarChangeListener(new SeekBar.OnSeekBarChangeListener() {
            @Override
            public void onProgressChanged(SeekBar seekBar, int i, boolean b) {
                Map<String, Object> m = new HashMap<>();
                m.put("value", i);
                if (i > 0) {
                    AppSeekBar.this.fireEvent("change", m);
                }
            }

            @Override
            public void onStartTrackingTouch(SeekBar seekBar) {
                AppSeekBar.this.fireEvent("start", new HashMap<String, Object>());
            }

            @Override
            public void onStopTrackingTouch(SeekBar seekBar) {
                AppSeekBar.this.fireEvent("stop", new HashMap<String, Object>());
            }
        });
        view.removeAllViews();
        view.addView(seekBar);
        return view;
    }

    private void setSeekBarColor(SeekBar seekBar, int color) {
        LayerDrawable layerDrawable = (LayerDrawable) seekBar.getProgressDrawable();
        Drawable dra = layerDrawable.getDrawable(2);
        dra.setColorFilter(color, PorterDuff.Mode.SRC);
        seekBar.getThumb().setColorFilter(color, PorterDuff.Mode.SRC_ATOP);
        seekBar.invalidate();
    }

    @WXComponentProp(name = "color")
    public void setColor(String color) {
        setSeekBarColor(seekBar, Color.parseColor(color));
    }

    @JSMethod
    @WXComponentProp(name = "progress")
    public void setProgress(int progress) {
        seekBar.setProgress(progress);
    }

    @WXComponentProp(name = "max")
    public void setMax(int max) {
        seekBar.setMax(max);
    }

    @WXComponentProp(name = "min")
    public void setMin(int min) {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            seekBar.setMin(min);
        }
    }
}
