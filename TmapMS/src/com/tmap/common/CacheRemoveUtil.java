package com.tmap.common;

import java.io.IOException;
import java.io.StringReader;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.List;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;

import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.NameValuePair;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.params.HttpParams;
import org.apache.http.util.EntityUtils;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.NamedNodeMap;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.xml.sax.InputSource;
import org.xml.sax.SAXException;

public class CacheRemoveUtil {
  
  
  
  private String getFullUrl(ConnectInfo connectInfo) {
    return "http://" + connectInfo.toString() + "/IFRS_REMOVE_CACHE.do";
  }
  
  public String requestCache(List <NameValuePair> nameValuePairList, ConnectInfo connectInfo) {
    String result = "";
    String errorCode = "";
    DefaultHttpClient httpclient = new DefaultHttpClient();
    httpclient.getParams().setParameter("http.connection.timeout",  2000);
    HttpPost httpPost = null;

    try {
      httpPost = new HttpPost(getFullUrl(connectInfo));
      httpPost.setEntity(new UrlEncodedFormEntity(nameValuePairList));
      HttpResponse response = httpclient.execute(httpPost);     
      HttpEntity entity = response.getEntity();
      result = EntityUtils.toString(entity);
      DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
      DocumentBuilder builder = factory.newDocumentBuilder();
      
     Document doc = builder.parse(new InputSource(new StringReader(result)));
     Element root = doc.getDocumentElement();
     //NodeList list = root.getElementsByTagName("MultiData");
     NodeList all = root.getChildNodes();
     for(int i = 0 ; i<all.getLength() ; i++){
    	    Node node = all.item(i);
    	    if(node.getNodeType() == Node.ELEMENT_NODE){
    	    	NamedNodeMap nnm = node.getAttributes();
    	    	Node code = nnm.getNamedItem("ErrorCode");
    	    	errorCode = code.getNodeValue();
    	    }
     }
      
      EntityUtils.consume(entity);
    } catch (UnsupportedEncodingException e) {
      e.printStackTrace();
    } catch (ClientProtocolException e) {
      e.printStackTrace();
    } catch (IOException e) {
      e.printStackTrace();
    } catch (ParserConfigurationException e){
    	e.printStackTrace();
    } catch (SAXException e){
    	e.printStackTrace();
    } finally {
      httpPost.releaseConnection();
    }
       
    return errorCode;
  }
  
  public HttpParams getHttpParams(List <NameValuePair> nameValuePairList, ConnectInfo connectInfo) {
    HttpParams httpParams = null;
    DefaultHttpClient httpclient = new DefaultHttpClient();
    HttpPost httpPost = null;

    try {
      httpPost = new HttpPost(getFullUrl(connectInfo));
      httpPost.setEntity(new UrlEncodedFormEntity(nameValuePairList));
      
      HttpResponse response = httpclient.execute(httpPost);
      httpParams = response.getParams();      
      HttpEntity entity = response.getEntity();
      EntityUtils.consume(entity);
    } catch (UnsupportedEncodingException e) {
      e.printStackTrace();
    } catch (ClientProtocolException e) {
      e.printStackTrace();
    } catch (IOException e) {
      e.printStackTrace();
    } finally {
      httpPost.releaseConnection();
    }
    return httpParams;
  }
    
  public String requestCacheRemove(String parameterName, String cacheType, ConnectInfo connectInfo) {
    String result = "";
    try {
      List <NameValuePair> nameValuePairList = new ArrayList <NameValuePair>();
      nameValuePairList.add(new BasicNameValuePair(parameterName, cacheType));
      result = requestCache(nameValuePairList, connectInfo);
    } catch (Exception e) {
      e.printStackTrace();
    } 
    return result;
  }
  
  public String requestCacheRemove(BasicNameValuePair basicNameValuePair, ConnectInfo connectInfo) {
    String result = "";
    
    try {
      List <NameValuePair> nameValuePairList = new ArrayList <NameValuePair>();
      nameValuePairList.add(basicNameValuePair);
      result = requestCache(nameValuePairList, connectInfo);
    } catch (Exception e) {
      e.printStackTrace();
    } 
    return result;
  }
  
  public String requestCacheRemove(List <NameValuePair> nameValuePairList, ConnectInfo connectInfo) {
    String result = "";
  
    try {
      result = requestCache(nameValuePairList, connectInfo);
    } catch (Exception e) {
      e.printStackTrace();
    } 
    return result;
  }
  
}
