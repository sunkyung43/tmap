package com.tmap.common;

public enum CacheType {
    CERTTIME(1, "CERTTIME"),
    STATECODE(2, "STATECODE"),
    RMVERSIONCHECK(3, "RMVERSIONCHECK"),
    SECURITYCODE(4, "SECURITYCODE"),
    TESTPHONE(5, "TESTPHONE"),
    ETC(6, "ETC");
    
    int mStatusCode;
    String mStatusMessage;
  
    CacheType(int statusCode, String type) {
      mStatusCode = statusCode;
      mStatusMessage = type;
    }
  
    @Override
    public String toString() {
      return String.valueOf(mStatusCode);
    }
  
    static CacheType getCacheType(String cacheTypeName) {
      for (CacheType cacheType : CacheType.values()) {
        if (cacheType.mStatusMessage.equals(cacheTypeName)) {
          return cacheType;
        }
      }
  
      return CacheType.ETC;
    }
  
    static CacheType getCacheType(int statusCode) {
      for (CacheType cacheType : CacheType.values()) {
        if (statusCode == cacheType.mStatusCode) {
          return cacheType;
        }
      }
  
      CacheType rCacheType = CacheType.ETC;
      rCacheType.mStatusCode = statusCode;
      return rCacheType;
    }
  }