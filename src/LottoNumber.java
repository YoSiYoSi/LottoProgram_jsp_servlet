

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.URL;
import javax.net.ssl.HostnameVerifier;
import javax.net.ssl.HttpsURLConnection;
import javax.net.ssl.SSLSession;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.json.JSONObject;

@WebServlet("/LottoNumber")
public class LottoNumber extends HttpServlet {
 private static final long serialVersionUID = 1L;
       
    public LottoNumber() {
        super();
    }

 protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
  int count = Integer.parseInt(request.getParameter("count"));
  response.getWriter().append(nanumlotto(count));
 }

 protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
  doGet(request, response);
 }
 private static class CustomizedHostnameVerifier implements HostnameVerifier {
  public boolean verify(String hostname, SSLSession session) {
   return true;
  }
 }

 public String nanumlotto(int count) {
  JSONObject result = new JSONObject();
  try {
   HttpsURLConnection connection = (HttpsURLConnection) new URL(
     "https://www.nlotto.co.kr/common.do?method=getLottoNumber&drwNo=" + count).openConnection();
   connection.setHostnameVerifier(new CustomizedHostnameVerifier());
   InputStreamReader isr = new InputStreamReader(connection.getInputStream(), "UTF-8");
   BufferedReader br = new BufferedReader(isr);
   String str = "";
   str = br.readLine();
   result = new JSONObject(str);
   System.out.println(result.get("drwtNo1"));
   System.out.println(result.get("drwtNo2"));
   System.out.println(result.get("drwtNo3"));
   System.out.println(result.get("drwtNo4"));
   System.out.println(result.get("drwtNo5"));
   System.out.println(result.get("drwtNo6"));
   System.out.println("���ʽ���ȣ= " + result.get("bnusNo"));
  } catch (Exception e1) {
   e1.printStackTrace();
  }
  return result.toString();
 }
}
