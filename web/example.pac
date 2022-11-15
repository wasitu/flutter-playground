function FindProxyForURL(url, host) {
    // 以下はテストで適当なプロキシを通す
    if (shExpMatch(url, "https://www.apple.com*")) return "PROXY https://sample.proxy:1000";
    if (shExpMatch(url, "https://api.stg.*/folders/*")) return "PROXY https://sample.proxy:1000";

    return "DIRECT";
}