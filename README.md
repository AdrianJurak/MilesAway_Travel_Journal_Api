# Aplikacja Turystyczna - Backend &amp; API
REST API dla aplikacji mobilnej (Flutter) oraz webowy panel
administracyjny do zarządzania podróżami i statystykami.
## �� Stack Technologiczny
* **Język i Framework:** PHP 8.3+, Laravel (13/12)
* **Baza danych:** PostgreSQL 16
* **Panel Administracyjny:** Laravel Filament v3
* **Autoryzacja API:** Laravel Sanctum (Token-based)
* **Środowisko:** Docker &amp; Docker Compose (Laravel Sail)
* **Jakość kodu i Testy:** PHPUnit, Laravel Pint
* **Integracje GIS:** OpenRouteService / OSRM (wyznaczanie tras),
  Nominatim / Photon (geokodowanie)
## �� Inicjalizacja projektu (Lokalnie)
Wymagania: Zainstalowany **Docker** oraz **Docker Compose**.
1. **Sklonuj repozytorium:**
```bash
git clone &lt;URL_REPOZYTORIUM&gt;
cd &lt;NAZWA_FOLDERU&gt;
```
2. **Skonfiguruj zmienne środowiskowe:**
```bash
cp .env.example .env
```
*(Upewnij się, że w `.env` ustawione są poprawne dane dla
PostgreSQL).*
3. **Zainstaluj zależności (używając kontenera tymczasowego,
   jeśli nie masz lokalnie PHP):**
```bash
docker run --rm \
-u &quot;$(id -u):$(id -g)&quot; \
-v &quot;$(pwd):/var/www/html&quot; \
-w /var/www/html \
laravelsail/php83-composer:latest \
composer install --ignore-platform-reqs
```
4. **Uruchom kontenery:**

```bash
./vendor/bin/sail up -d
```
5. **Wygeneruj klucz aplikacji i uruchom migracje:**
```bash
./vendor/bin/sail artisan key:generate
./vendor/bin/sail artisan migrate
```
**Dostęp po uruchomieniu:**
* Aplikacja / API: `http://localhost`
* Panel Administratora: `http://localhost/admin`
