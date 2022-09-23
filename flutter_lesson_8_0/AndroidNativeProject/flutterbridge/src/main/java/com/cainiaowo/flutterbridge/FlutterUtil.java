package com.cainiaowo.flutterbridge;

import android.content.Context;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;

public class FlutterUtil {
    public static final String FLUTTER_SO_NAME = "libflutter.so";

    /**
     * 将文件从assets目录，考贝到 /data/data/包名/files/ 目录中。assets 目录中的文件，会不经压缩打包至APK包中，使用时还应从apk包中导出来
     */
    public static void copyAssetsFile2flutter(Context context) {
        try {
            InputStream inputStream = context.getAssets().open(FLUTTER_SO_NAME);
            //getFilesDir() 获得当前APP的安装路径 /data/data/包名/files 目录
            File file = new File(context.getDir("flutter", Context.MODE_PRIVATE).getPath() + File.separator + FLUTTER_SO_NAME);
            if (!file.exists() || file.length() == 0) {
                FileOutputStream fos = new FileOutputStream(file);//如果文件不存在，FileOutputStream会自动创建文件
                int len = -1;
                byte[] buffer = new byte[1024];
                while ((len = inputStream.read(buffer)) != -1) {
                    fos.write(buffer, 0, len);
                }
                fos.flush();//刷新缓存区
                inputStream.close();
                fos.close();
            } else {
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }


}
