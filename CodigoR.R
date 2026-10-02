library(ggplot2)
library(dplyr)



###### Leer los datos

datos <- read.csv("Social_media_impact_on_life.csv")

###### Limpieza de Datos

datos <- datos %>%
  mutate(
    # --- FACTORES NOMINALES (Categorías sin un orden intrínseco) ---
    Gender           = as.factor(Gender),
    Primary_Platform = as.factor(Primary_Platform),
    Device_Type      = as.factor(Device_Type),
    
    # --- FACTORES ORDINALES (Categorías con una jerarquía clara) ---
    
    # Nivel Académico: de menor a mayor grado
    Academic_Level = ordered(Academic_Level, 
                             levels = c("High School", "Undergraduate", "Postgraduate")),
    
    # Frecuencia de Comparación Social: de menor a mayor frecuencia
    Social_Comparison_Frequency = ordered(Social_Comparison_Frequency, 
                                          levels = c("Never", "Rarely", "Sometimes", "Frequently", "Always")),
    
    # Impacto General: de negativo a positivo
    Overall_Impact = ordered(Overall_Impact, 
                             levels = c("Negative", "Neutral", "Beneficial"))
  )

datos <- datos %>%
  mutate(
    Late_Night_Usage = factor(
      # Pasamos a minúsculas para estandarizar ("true" o "false")
      tolower(Late_Night_Usage), 
      levels = c("true", "false"),
      labels = c("Sí", "No") # Reemplaza "true" por "Sí" y "false" por "No"
    )
  )

###### 3. Variables que NO se modifican (se quedan como están)
# Student_ID                  -> Se mantiene como [character] (es un identificador único)
# Age                         -> Se mantiene como [integer]
# Daily_Usage_Hours           -> Se mantiene como [numeric]
# Weekend_Extra_Hours         -> Se mantiene como [numeric]
# Sleep_Duration_Hours        -> Se mantiene como [numeric]
# Sleep_Quality_Score         -> Se mantiene como [integer] (o numérico de escala)
# Perceived_Stress_Score      -> Se mantiene como [integer]
# Mental_Health_Index         -> Se mantiene como [integer]
# Academic_Performance_GPA    -> Se mantiene como [numeric]


##### Partición de los datos

n = dim(datos)[1]



##### Guardar datos

save(datos, file = "datos.Rdata")


##### Gráficas


summary(datos)

ggplot(datos, aes(x = factor(Age), y = Sleep_Duration_Hours)) +
  geom_boxplot(fill = "skyblue", color = "darkblue") +
  labs(title = "Duración del Sueño por Edad", 
       x = "Edad", 
       y = "Horas de Sueño") +
  theme_minimal()


datos <- read.csv("Social_media_impact_on_life.csv")

