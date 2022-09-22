package com.cainiaowo.androidnativeproject.plugins;// Autogenerated from Pigeon (v0.3.0), do not edit directly.
// See also: https://pub.dev/packages/pigeon


import java.util.HashMap;
import java.util.Map;

import io.flutter.plugin.common.BasicMessageChannel;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.StandardMessageCodec;

/** Generated class from Pigeon. */
@SuppressWarnings({"unused", "unchecked", "CodeBlock2Expr", "RedundantSuppression"})
public class RequestChannel {

  /** Generated class from Pigeon that represents data sent in messages. */
  public static class RequestParams {
    private String requestName;
    public String getRequestName() { return requestName; }
    public void setRequestName(String setterArg) { this.requestName = setterArg; }

    private String requestVersion;
    public String getRequestVersion() { return requestVersion; }
    public void setRequestVersion(String setterArg) { this.requestVersion = setterArg; }

    Map<String, Object> toMap() {
      Map<String, Object> toMapResult = new HashMap<>();
      toMapResult.put("requestName", requestName);
      toMapResult.put("requestVersion", requestVersion);
      return toMapResult;
    }
    static RequestParams fromMap(Map<String, Object> map) {
      RequestParams fromMapResult = new RequestParams();
      Object requestName = map.get("requestName");
      fromMapResult.requestName = (String)requestName;
      Object requestVersion = map.get("requestVersion");
      fromMapResult.requestVersion = (String)requestVersion;
      return fromMapResult;
    }
  }

  /** Generated class from Pigeon that represents data sent in messages. */
  public static class Reply {
    private String replyName;
    public String getReplyName() { return replyName; }
    public void setReplyName(String setterArg) { this.replyName = setterArg; }

    private String replyVersion;
    public String getReplyVersion() { return replyVersion; }
    public void setReplyVersion(String setterArg) { this.replyVersion = setterArg; }

    Map<String, Object> toMap() {
      Map<String, Object> toMapResult = new HashMap<>();
      toMapResult.put("replyName", replyName);
      toMapResult.put("replyVersion", replyVersion);
      return toMapResult;
    }
    static Reply fromMap(Map<String, Object> map) {
      Reply fromMapResult = new Reply();
      Object replyName = map.get("replyName");
      fromMapResult.replyName = (String)replyName;
      Object replyVersion = map.get("replyVersion");
      fromMapResult.replyVersion = (String)replyVersion;
      return fromMapResult;
    }
  }

  /** Generated interface from Pigeon that represents a handler of messages from Flutter.*/
  public interface RequestChannelAPI {
    Reply getFinalRequestParams(RequestParams arg);

    /** Sets up an instance of `RequestChannelAPI` to handle messages through the `binaryMessenger`. */
    static void setup(BinaryMessenger binaryMessenger, RequestChannelAPI api) {
      {
        BasicMessageChannel<Object> channel =
            new BasicMessageChannel<>(binaryMessenger, "dev.flutter.pigeon.RequestChannelAPI.getFinalRequestParams", new StandardMessageCodec());
        if (api != null) {
          channel.setMessageHandler((message, reply) -> {
            Map<String, Object> wrapped = new HashMap<>();
            try {
              @SuppressWarnings("ConstantConditions")
              RequestParams input = RequestParams.fromMap((Map<String, Object>)message);
              Reply output = api.getFinalRequestParams(input);
              wrapped.put("result", output.toMap());
            }
            catch (Error | RuntimeException exception) {
              wrapped.put("error", wrapError(exception));
            }
            reply.reply(wrapped);
          });
        } else {
          channel.setMessageHandler(null);
        }
      }
    }
  }
  private static Map<String, Object> wrapError(Throwable exception) {
    Map<String, Object> errorMap = new HashMap<>();
    errorMap.put("message", exception.toString());
    errorMap.put("code", exception.getClass().getSimpleName());
    errorMap.put("details", null);
    return errorMap;
  }
}