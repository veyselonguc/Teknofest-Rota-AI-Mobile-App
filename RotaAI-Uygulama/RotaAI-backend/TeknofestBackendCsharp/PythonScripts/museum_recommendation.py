import sys
import json
import base64
import pandas as pd
from sklearn.feature_extraction.text import TfidfVectorizer
from sklearn.metrics.pairwise import cosine_similarity
import numpy as np
import os
from sklearn.preprocessing import StandardScaler
import pyodbc
import traceback

# Encoding ayarlarını yap
import codecs
sys.stdout = codecs.getwriter('utf-8')(sys.stdout.buffer)

# Kategori anahtar kelimeleri
kategori_kelimeleri = {
    "Tarihi Saray": ["saray", "osmanli", "padisah", "sultan", "hanedan", "divan", "harem", 
                     "topkapi", "dolmabahce", "beylerbeyi", "yildiz", "ciragan", "sarayi", "sarayin",
                     "padisah", "sultan", "hanedan", "osmanli", "tarihi saray", "saray muzesi",
                     "osmanli sarayi", "sultan sarayi", "padisah sarayi", "saray kompleksi",
                     "saray bahcesi", "saray kapisi", "saray avlusu", "saray odasi", "saray salonu",
                     "saray mimarisi", "saray suslemeleri", "saray koleksiyonu", "saray hazinesi",
                     "saray kutuphanesi", "saray mutfagi", "saray hamami", "saray camisi",
                     "saray turbesi", "saray meydani", "saray surlari", "saray kapisi"],
    "Sanat Müzesi": ["sanat", "resim", "tablo", "heykel", "sergi", "galeri", "modern", "sanatci", 
                     "eser", "koleksiyon", "guzel sanatlar", "resim galerisi", "sanat galerisi",
                     "sergi salonu", "sanat eseri", "tablo galerisi", "sanat muzesi", "resim muzesi",
                     "heykel muzesi", "sanat sergisi", "sanat koleksiyonu", "sanat galerisi",
                     "sanat atolyesi", "sanat okulu", "sanat akademisi", "sanat merkezi"],
    "Arkeoloji Müzesi": ["arkeoloji", "antik", "eski", "kazi", "arkeolojik", "tarih oncesi", 
                         "misir", "roma", "yunan", "antik cag", "arkeolojik kazi", "eski uygarlik",
                         "antik eser", "arkeolojik eser", "tarih oncesi eser", "arkeoloji muzesi",
                         "antik eserler", "arkeolojik buluntular", "tarih oncesi buluntular",
                         "arkeolojik alan", "arkeolojik site", "arkeolojik kazi alani"],
    "Bilim Müzesi": ["bilim", "teknoloji", "deney", "kesif", "uzay", "robot", "bilimsel", 
                     "planetarium", "bilim merkezi", "teknoloji merkezi", "bilimsel deney",
                     "bilimsel kesif", "bilimsel arastirma", "bilimsel gelisme", "bilim muzesi",
                     "teknoloji muzesi", "bilim ve teknoloji", "bilimsel arastirma merkezi",
                     "bilim laboratuvari", "bilim atolyesi", "bilim okulu", "bilim akademisi",
                     "cocuk muzesi", "egitim", "ogrenme", "interaktif"],
    "Askeri Müze": ["askeri", "savas", "ordu", "silah", "zirh", "top", "asker", "muharebe", 
                     "tank", "ucak", "askeri tarih", "savas tarihi", "askeri koleksiyon",
                     "askeri tecizat", "askeri arac", "askeri silah", "askeri muzesi", "savas muzesi",
                     "askeri tarih muzesi", "askeri koleksiyonlar", "askeri araclar",
                     "askeri tecizatlar", "askeri silahlar", "askeri ekipmanlar"],
    "Etnografya Müzesi": ["etnografya", "kultur", "gelenek", "halk", "yasam", "el sanatlari", 
                           "geleneksel", "folklor", "halk kulturu", "geleneksel yasam",
                           "el sanati", "halk sanati", "kulturel miras", "geleneksel kultur",
                           "etnografya muzesi", "kultur muzesi", "halk kulturu muzesi",
                           "geleneksel kultur muzesi", "halk sanatlari", "geleneksel sanatlar"],
    "Modern Sanat": ["modern", "cagdas", "avangard", "deneysel", "contemporary", "modern sanat",
                      "cagdas sanat", "modern sanat galerisi", "cagdas sanat muzesi",
                      "modern sanat sergisi", "modern sanat eseri", "cagdas sanat eseri",
                      "modern sanat muzesi", "cagdas sanat galerisi", "modern sanat koleksiyonu"],
    "Tarihi Yapı": ["tarihi", "eski", "antik", "bina", "yapi", "mimari", "restore", "kale", 
                     "kule", "surlar", "tarihi bina", "tarihi yapi", "tarihi mimari",
                     "tarihi eser", "tarihi mekan", "tarihi yer", "tarihi yapi muzesi",
                     "kopru", "kapi", "hisar", "burc", "surlar", "kale surlari", "tarihi yapi",
                     "tarihi mimari", "tarihi eser", "tarihi mekan", "tarihi yer"],
    "Park ve Bahçe": ["park", "bahce", "arboretum", "botanik", "agac", "cicek", "yesil", 
                       "doga", "orman", "botanik bahce", "yesil alan", "rekreasyon alani",
                       "dogal park", "yesil park", "botanik park", "park muzesi", "bahce muzesi",
                       "botanik bahce muzesi", "doga parki", "yesil alan muzesi"],
    "Sahil ve Plaj": ["sahil", "plaj", "deniz", "kumsal", "kiyi", "beach", "coast", "shore",
                       "deniz kiyisi", "sahil seridi", "kumsal plaj", "deniz manzarasi",
                       "sahil yolu", "kiyi seridi", "deniz kenari", "sahil muzesi",
                       "deniz muzesi", "sahil parki", "deniz kiyisi muzesi"],
    "Tepeler ve Manzara": ["tepe", "manzara", "panorama", "gorus", "view", "hill", "peak",
                           "manzara noktasi", "panoramik gorus", "tepe manzarasi",
                           "yuksek nokta", "gorus noktasi", "manzara tepesi", "tepe muzesi",
                           "manzara muzesi", "panorama muzesi", "gorus noktasi muzesi"],
    "Denizcilik Müzesi": ["denizcilik", "deniz", "gemi", "tekne", "denizcilik tarihi",
                          "denizcilik muzesi", "denizcilik koleksiyonu", "denizcilik eseri",
                          "denizcilik araci", "denizcilik ekipmani", "denizcilik tarihi",
                          "denizcilik kulturu", "denizcilik mirasi", "gemi muzesi",
                          "denizcilik tarihi muzesi", "denizcilik koleksiyonlari"]
}

def kategori_belirle(metin):
    """Geliştirilmiş kategori belirleme"""
    metin = metin.lower()
    kelimeler = metin.split()
    kategori_skorlari = {}
    
    for kategori, anahtar_kelimeler in kategori_kelimeleri.items():
        skor = 0
        for kelime in kelimeler:
            for anahtar in anahtar_kelimeler:
                if anahtar in kelime or kelime in anahtar:
                    skor += 1
                    break
        kategori_skorlari[kategori] = skor
    
    # Özel durumlar için kontrol
    if "kopru" in metin or "köprü" in metin:
        return "Tarihi Yapı"
    if "kule" in metin or "kule" in metin:
        return "Tarihi Yapı"
    if "hisar" in metin or "hisar" in metin:
        return "Tarihi Yapı"
    if "burc" in metin or "burç" in metin:
        return "Tarihi Yapı"
    
    en_yuksek_skor = max(kategori_skorlari.values())
    if en_yuksek_skor == 0:
        return "Diğer"
    
    return max(kategori_skorlari.items(), key=lambda x: x[1])[0]

def load_museum_data():
    try:
        # Script'in bulunduğu dizini al
        script_dir = os.path.dirname(os.path.abspath(__file__))
        json_path = os.path.join(script_dir, 'MuzelerinYorumlari(200M-100Y).json')
        
        # JSON dosyasını UTF-8 encoding ile oku
        with open(json_path, 'r', encoding='utf-8') as file:
            data = json.load(file)
            
        # JSON verisini DataFrame'e dönüştür
        museums = []
        for yer in data['yerler']:
            # Tüm yorumları birleştir
            tum_yorumlar = ' '.join([comment['yorum'] for comment in yer['yorumlar']])
            # Kategoriyi belirle
            kategori = kategori_belirle(tum_yorumlar)
            
            museums.append({
                'name': yer['isim'],
                'category': kategori,
                'description': tum_yorumlar
            })
            
        df = pd.DataFrame(museums)
        return df
    except Exception as e:
        print(json.dumps({"error": f"Veri yükleme hatası: {str(e)}"}, ensure_ascii=False))
        sys.exit(1)

def get_db_connection(connection_string):
    try:
        print(f"Bağlantı dizesi: {connection_string}")
        conn = pyodbc.connect(connection_string)
        print("Veritabanı bağlantısı başarılı!")
        return conn
    except Exception as e:
        print(f"Veritabanı bağlantı hatası: {str(e)}")
        print(f"Hata detayı: {traceback.format_exc()}")
        raise

def get_user_visited_places(user_id):
    try:
        conn = get_db_connection()
        cursor = conn.cursor()
        
        query = """
        SELECT PlaceId, Point
        FROM VisitedPlaces
        WHERE UserId = ?
        """
        
        cursor.execute(query, user_id)
        results = cursor.fetchall()
        
        visited_places = [row[0] for row in results]
        points = [row[1] for row in results]
        
        cursor.close()
        conn.close()
        
        return visited_places, points
    except Exception as e:
        print(f"Ziyaret edilen yerleri alma hatası: {str(e)}", file=sys.stderr)
        raise

def get_all_places(conn):
    try:
        cursor = conn.cursor()
        query = """
        SELECT p.PlaceId, p.PlaceName, p.PlaceDesc, c.CityName
        FROM Places p
        JOIN Cities c ON p.CityId = c.CityId
        """
        cursor.execute(query)
        results = cursor.fetchall()
        
        places = []
        for row in results:
            places.append({
                "placeId": row[0],
                "name": row[1],
                "description": row[2],
                "city": row[3],
                "category": "museum"  # Varsayılan kategori
            })
        
        cursor.close()
        print(f"Toplam {len(places)} yer bulundu")
        return places
    except Exception as e:
        print(f"Yerler alınırken hata: {str(e)}")
        print(f"Hata detayı: {traceback.format_exc()}")
        raise

def create_place_features(places):
    try:
        # Metin özelliklerini oluştur
        texts = [f"{p['name']} {p['description']} {p['city']}" for p in places]
        vectorizer = TfidfVectorizer()
        tfidf_matrix = vectorizer.fit_transform(texts)
        print("Özellik vektörleri oluşturuldu")
        return tfidf_matrix
    except Exception as e:
        print(f"Özellik oluşturma hatası: {str(e)}")
        print(f"Hata detayı: {traceback.format_exc()}")
        raise

def print_log(message):
    print(message, file=sys.stderr)

def get_recommendations(visited_places, connection_string):
    try:
        print_log("Veritabanına bağlanılıyor...")
        print_log(f"Bağlantı dizesi: {connection_string}")
        
        # ODBC sürücüsünü kontrol et
        available_drivers = [x for x in pyodbc.drivers()]
        print_log(f"Mevcut ODBC sürücüleri: {available_drivers}")
        
        if not any('SQL Server' in driver for driver in available_drivers):
            print_log("HATA: SQL Server ODBC sürücüsü bulunamadı!")
            print_log("Lütfen 'ODBC Driver 17 for SQL Server' sürücüsünü yükleyin.")
            return []
        
        conn = pyodbc.connect(connection_string)
        cursor = conn.cursor()
        
        print_log("Veritabanı bağlantısı başarılı")
        
        # Tüm yerleri al
        cursor.execute("""
            SELECT p.PlaceId, p.PlaceName, p.PlaceImage, p.PlaceDesc, c.CityName
            FROM Places p
            JOIN Cities c ON p.CityId = c.CityId
        """)
        
        all_places = cursor.fetchall()
        print_log(f"Toplam {len(all_places)} yer bulundu")
        
        if not all_places:
            print_log("Veritabanında yer bulunamadı")
            return []
            
        # Ziyaret edilen yerleri bul
        visited_place_ids = [place['PlaceId'] for place in visited_places]
        print_log(f"Ziyaret edilen yerler: {visited_place_ids}")
        
        # Benzerlik hesaplama için metin verilerini hazırla
        texts = [f"{place.PlaceName} {place.PlaceDesc}" for place in all_places]
        vectorizer = TfidfVectorizer()
        tfidf_matrix = vectorizer.fit_transform(texts)
        
        # Benzerlik skorlarını hesapla
        similarity_scores = cosine_similarity(tfidf_matrix)
        
        # Önerileri oluştur
        recommendations = []
        for visited_id in visited_place_ids:
            visited_idx = next((i for i, place in enumerate(all_places) if place.PlaceId == visited_id), None)
            if visited_idx is not None:
                # Benzerlik skorlarını al
                scores = similarity_scores[visited_idx]
                
                # En yüksek benzerlik skoruna sahip yerleri bul (ziyaret edilenler hariç)
                top_indices = np.argsort(scores)[::-1][1:6]
                
                for idx in top_indices:
                    place = all_places[idx]
                    if place.PlaceId not in visited_place_ids:
                        recommendations.append({
                            "PlaceId": place.PlaceId,
                            "PlaceName": place.PlaceName,
                            "PlaceImage": place.PlaceImage,
                            "PlaceDesc": place.PlaceDesc,
                            "CityName": place.CityName,
                            "RecommendationScore": float(scores[idx])
                        })
        
        # Önerileri skorlarına göre sırala ve tekrarları kaldır
        recommendations = sorted(recommendations, key=lambda x: x["RecommendationScore"], reverse=True)
        unique_recommendations = []
        seen_ids = set()
        
        for rec in recommendations:
            if rec["PlaceId"] not in seen_ids:
                unique_recommendations.append(rec)
                seen_ids.add(rec["PlaceId"])
        
        print_log(f"Toplam {len(unique_recommendations)} benzersiz öneri oluşturuldu")
        return unique_recommendations[:5]  # En iyi 5 öneriyi döndür
        
    except pyodbc.Error as e:
        print_log(f"Veritabanı bağlantı hatası: {str(e)}")
        return []
    except Exception as e:
        print_log(f"Hata oluştu: {str(e)}")
        return []
    finally:
        if 'conn' in locals():
            conn.close()

def main():
    try:
        if len(sys.argv) != 3:
            print_log("Hata: Geçersiz argüman sayısı")
            sys.exit(1)
            
        # Base64 kodlu JSON verisini çöz
        visited_places_json = base64.b64decode(sys.argv[1]).decode('utf-8')
        visited_places = json.loads(visited_places_json)
        
        print_log(f"Ziyaret edilen yerler alındı: {visited_places}")
        
        # Veritabanı bağlantı bilgilerini al
        connection_string = sys.argv[2]
        
        # Önerileri al
        recommendations = get_recommendations(visited_places, connection_string)
        
        # Sonuçları JSON olarak yazdır
        if recommendations:
            print(json.dumps(recommendations, ensure_ascii=False))
        else:
            print("[]")
            
    except Exception as e:
        print_log(f"Ana program hatası: {str(e)}")
        print("[]")
        sys.exit(1)

if __name__ == "__main__":
    main() 