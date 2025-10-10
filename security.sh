#!/bin/bash

set -e

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
NC='\033[0m'

# Simple and smooth logging functions
log() {
    echo -e "${GREEN}✓${NC} $1"
}

warn() {
    echo -e "${YELLOW}!${NC} $1"
}

error() {
    echo -e "${RED}✗${NC} $1"
    exit 1
}

info() {
    echo -e "${BLUE}>${NC} $1"
}

process() {
    echo -e "${BLUE}→${NC} $1"
}

license_info() {
    echo -e "${PURPLE}♠${NC} $1"
}

route_info() {
    echo -e "${GREEN}✓${NC} $1"
}

# Loading bar function
show_loading() {
    local text=$1
    local duration=2
    local steps=20
    local step_duration=$(echo "scale=3; $duration/$steps" | bc)
    
    printf "    ${text} ["
    for ((i=0; i<steps; i++)); do
        printf "▰"
        sleep $step_duration
    done
    printf "] Done!\n"
}

# License verification
verify_license() {
    echo
    license_info "License Verification"
    echo "======================"
    echo
    read -p "Enter license key: " license_key
    
    if [ -z "$license_key" ]; then
        error "License key cannot be empty!"
    fi
    
    # Simple license verification (naeldev)
    if [ "$license_key" != "naeldev" ]; then
        error "Invalid license key! Access denied."
    fi
    
    show_loading "Verifying license"
    log "License verified successfully!"
    echo
    license_info "Licensed to: @naeldev"
    license_info "Valid for: Custom Security Middleware"
    license_info "Type: Single Domain License"
    echo
}

show_menu() {
    clear
    cat <<'EOF'
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣤⣦⣤⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠄⠒⠒⠉⣩⣽⣿⣿⣿⣿⣿⠿⢿⣶⣶⣤⣄⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠰⣿⣿⣿⣿⣿⣿⣿⡷⠀⠈⠙⠻⢿⣿⣷⣤⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⣾⣿⠿⣿⣿⣿⠏⠀⠀⠀⠀⠀⠀⠉⠻⣿⣿⣷⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⣤⣴⣶⣿⣿⣿⣿⣦⣄⣾⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠻⣿⣿⣷⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢹⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⢿⣿⣿⣦⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⣿⣿⣿⣿⣿⠏⠉⢹⣿⣿⣇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⢿⣿⣿⣷⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⣿⣿⣿⣿⣁⡀⠀⢸⣿⣿⣿⣷⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⢿⣿⣿⣷⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⣿⣿⣿⣿⣷⠀⢸⣿⣿⡇⠻⣿⣦⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⣿⣿⣿⣇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣸⣿⣿⣿⣿⣿⣷⣼⣿⣿⡇⠀⠈⠻⣿⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⣿⣿⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣰⣿⣿⣿⣿⣿⣿⣿⡃⠙⣿⣿⣄⡀⠀⠈⠙⢷⣄⠀⠀⠀⠀⠀⠀⠀⠀⢸⣿⣿⣿⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠺⣿⣿⣿⣿⣿⣿⣿⡟⠁⠀⠘⣿⣿⣿⣷⣶⣤⣈⡟⢳⢄⠀⠀⠀⠀⠀⠀⢸⣿⣿⣿⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣴⣿⣿⣿⣿⣿⣿⣿⡇⠀⠀⠀⢻⣿⣯⡉⠛⠻⢿⣿⣷⣧⡀⠀⠀⠀⠀⠀⣿⣿⣿⣿⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣼⣿⣿⣿⡿⠹⣿⣿⣿⣷⠀⠀⠀⢀⣿⣿⣷⣄⠀⠀⠈⠙⠿⣿⣄⠀⠀⠀⢠⣿⣿⣿⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢰⣿⣿⣿⠋⠀⣀⣻⣿⣿⣿⣀⣠⣶⣿⣿⣿⣿⣿⣷⣄⠀⠀⠀⠈⢹⠇⠀⠀⣾⣿⣿⣿⡏⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⣿⣿⣷⣿⣿⣿⣿⣿⣿⣿⣟⠛⠋⠉⠁⠀⠀⠀⠉⠻⢧⠀⠀⠀⠘⠃⠀⣼⣿⣿⣿⡿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢢⡀⠀⠀⠀⠀⢿⣿⣿⠿⠟⠛⠉⠁⠈⣿⣿⣿⡆⠀⠀⠀⠀⠀⠀⠀⠀⢺⠀⠀⠀⠀⢀⣾⣿⣿⣿⡿⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠳⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠸⣿⣿⣧⠀⠀⠀⠀⠀⠀⠀⠀⠊⠀⠀⠀⣰⣿⣿⣿⣿⠟⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⢷⣦⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢻⣿⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣤⣾⣿⣿⣿⡿⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⠿⣷⣤⣀⠀⠀⠀⠀⠀⠀⠀⠘⣿⣿⠀⠀⠀⠀⠀⠀⣀⣤⣶⣿⣿⣿⣿⡿⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠛⠿⣿⣶⣦⣤⣤⣀⣀⣀⣻⣿⣀⣀⣤⣴⣶⣿⣿⣿⣿⣿⠿⠛⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠛⠻⠿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠿⠟⠛⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⢿⣿⣯⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠸⣿⡟⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⡧⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠸⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
EOF

    echo
    echo "=========================================="
    echo "               Simple Option            "
    echo "    Custom Security Middleware Installer"
    echo "                 @naeldev               "
    echo "=========================================="
    echo
    echo "Menu options:"
    echo "1. Install Security Middleware"
    echo "2. Applying Routes"
    echo "3. Custom Error Message"
    echo "4. Clear Security (Uninstall)"
    echo "5. Exit"
    echo
}

show_license() {
    echo
    license_info "Software License Agreement"
    echo "=============================="
    echo
    echo "Product: Custom Security Middleware for Pterodactyl"
    echo "Version: 2.0"
    echo "License: naeldev"
    echo "Developer: @naeldev"
    echo
    echo "License Terms:"
    echo "• Single domain usage"
    echo "• Personal and commercial use allowed"
    echo "• Modification permitted"
    echo "• Redistribution not allowed"
    echo "• No warranty provided"
    echo
    echo "This software is protected by license key: naeldev"
    echo "Unauthorized use is prohibited."
    echo
}

clear_security() {
    echo
    info "Clear Security Middleware"
    echo "========================="
    echo
    warn "Warning: This will remove security middleware and restore system to normal!"
    read -p "Are you sure you want to remove security middleware? (y/N): " confirm
    
    if [[ ! "$confirm" =~ ^[Yy]$ ]]; then
        log "Removal cancelled."
        return
    fi
    
    PTERO_DIR="/var/www/pterodactyl"
    
    if [ ! -d "$PTERO_DIR" ]; then
        error "Pterodactyl directory not found: $PTERO_DIR"
    fi
    
    process "Cleaning up security middleware..."
    
    # 1. Remove middleware file
    if [ -f "$PTERO_DIR/app/Http/Middleware/CustomSecurityCheck.php" ]; then
        rm -f "$PTERO_DIR/app/Http/Middleware/CustomSecurityCheck.php"
        log "Middleware file removed"
    else
        warn "Middleware file not found"
    fi
    
    # 2. Remove from Kernel.php
    KERNEL_FILE="$PTERO_DIR/app/Http/Kernel.php"
    if [ -f "$KERNEL_FILE" ]; then
        if grep -q "custom.security" "$KERNEL_FILE"; then
            sed -i "/'custom.security' => \\\\Pterodactyl\\\\Http\\\\Middleware\\\\CustomSecurityCheck::class,/d" "$KERNEL_FILE"
            log "Middleware removed from Kernel"
        else
            warn "Middleware not registered in Kernel"
        fi
    fi
    
    # 3. Remove middleware from routes
    process "Cleaning routes..."
    
    # api-client.php
    API_CLIENT_FILE="$PTERO_DIR/routes/api-client.php"
    if [ -f "$API_CLIENT_FILE" ]; then
        if grep -q "Route::group(\['prefix' => '/files', 'middleware' => \['custom.security'\]" "$API_CLIENT_FILE"; then
            sed -i "s/Route::group(\['prefix' => '\/files', 'middleware' => \['custom.security'\]/Route::group(['prefix' => '\/files'/g" "$API_CLIENT_FILE"
            log "Middleware removed from api-client.php"
        fi
    fi
    
    # admin.php - remove middleware from all routes
    ADMIN_FILE="$PTERO_DIR/routes/admin.php"
    if [ -f "$ADMIN_FILE" ]; then
        sed -i "s/->middleware(\['custom.security'\])//g" "$ADMIN_FILE"
        log "Middleware removed from admin.php"
    fi
    
    # 4. Clear cache
    process "Clearing cache..."
    cd $PTERO_DIR
    sudo -u www-data php artisan config:clear
    sudo -u www-data php artisan route:clear
    sudo -u www-data php artisan view:clear
    sudo -u www-data php artisan cache:clear
    sudo -u www-data php artisan optimize
    
    log "Cache cleared"
    
    # 5. Restart services
    process "Restarting services..."
    
    PHP_SERVICE=""
    if systemctl is-active --quiet php8.2-fpm; then
        PHP_SERVICE="php8.2-fpm"
    elif systemctl is-active --quiet php8.1-fpm; then
        PHP_SERVICE="php8.1-fpm"
    elif systemctl is-active --quiet php8.0-fpm; then
        PHP_SERVICE="php8.0-fpm"
    elif systemctl is-active --quiet php8.3-fpm; then
        PHP_SERVICE="php8.3-fpm"
    fi
    
    if [ -n "$PHP_SERVICE" ]; then
        systemctl restart $PHP_SERVICE
        log "$PHP_SERVICE restarted"
    fi
    
    if systemctl is-active --quiet pteroq-service; then
        systemctl restart pteroq-service
        log "pterodactyl-service restarted"
    fi
    
    if systemctl is-active --quiet nginx; then
        systemctl reload nginx
        log "nginx reloaded"
    fi
    
    echo
    log "Security middleware successfully removed!"
    echo
    warn "System is now in NORMAL mode without security middleware protection"
}

replace_credit_name() {
    echo
    info "Change Credit Name"
    echo "=================="
    echo
    read -p "Enter new name to replace '@naeldev': " new_name
    
    if [ -z "$new_name" ]; then
        error "Name cannot be empty!"
    fi
    
    new_name=$(echo "$new_name" | sed 's/^@//')
    
    echo
    process "Replacing '@naeldev' with '@$new_name'..."
    
    if [ ! -f "$PTERO_DIR/app/Http/Middleware/CustomSecurityCheck.php" ]; then
        error "Middleware not installed! Please install first."
    fi
    
    sed -i "s/@naeldev/@$new_name/g" "$PTERO_DIR/app/Http/Middleware/CustomSecurityCheck.php"
    
    log "Name changed from '@naeldev' to '@$new_name'"
    
    show_loading "Clearing cache"
    cd $PTERO_DIR
    sudo -u www-data php artisan config:clear
    sudo -u www-data php artisan route:clear
    sudo -u www-data php artisan cache:clear
    
    echo
    log "Credit name updated successfully!"
    log "Current credit: @$new_name"
}

custom_error_message() {
    echo
    info "Custom Error Message"
    echo "===================="
    echo
    read -p "Enter custom error text (example: 'Access denied!'): " custom_error
    
    if [ -z "$custom_error" ]; then
        error "Error text cannot be empty!"
    fi
    
    echo
    process "Updating error message to: '$custom_error'..."
    
    if [ ! -f "$PTERO_DIR/app/Http/Middleware/CustomSecurityCheck.php" ]; then
        error "Middleware not installed! Please install first."
    fi
    
    sed -i "s/'error' => 'Mau ngapain hama wkwkwk - @naeldev'/'error' => '$custom_error'/g" "$PTERO_DIR/app/Http/Middleware/CustomSecurityCheck.php"
    
    log "Error message updated to: '$custom_error'"
    
    show_loading "Clearing cache"
    cd $PTERO_DIR
    sudo -u www-data php artisan config:clear
    sudo -u www-data php artisan route:clear
    sudo -u www-data php artisan cache:clear
    
    echo
    log "Error message updated successfully!"
}

apply_manual_routes() {
    process "Applying middleware to routes..."
    
    API_CLIENT_FILE="$PTERO_DIR/routes/api-client.php"
    if [ -f "$API_CLIENT_FILE" ]; then
        process "Processing api-client.php..."
        
        if grep -q "Route::group(\['prefix' => '/files'" "$API_CLIENT_FILE"; then
            if ! grep -q "Route::group(\['prefix' => '/files', 'middleware' => \['custom.security'\]" "$API_CLIENT_FILE"; then
                sed -i "s/Route::group(\['prefix' => '\/files'/Route::group(['prefix' => '\/files', 'middleware' => ['custom.security']/g" "$API_CLIENT_FILE"
                log "Applied to /files group in api-client.php"
            else
                warn "Already applied to /files group"
            fi
        else
            warn "/files group not found in api-client.php"
        fi
    fi

    ADMIN_FILE="$PTERO_DIR/routes/admin.php"
    if [ -f "$ADMIN_FILE" ]; then
        process "Processing admin.php..."
        
        # Backup original file
        cp "$ADMIN_FILE" "$ADMIN_FILE.backup"
        
        # Method 1: Manual line-by-line processing
        log "Processing routes line by line..."
        
        # Array of route patterns to protect
        routes_to_protect=(
            # Server routes
            "Route::get('/view/{server:id}/delete'"
            "Route::post('/view/{server:id}/delete'"
            "Route::patch('/view/{server:id}/details'"
            "Route::get('/view/{server:id}/details'"
            
            # User routes
            "Route::patch('/view/{user:id}'"
            "Route::delete('/view/{user:id}'"
            
            # Node routes
            "Route::get('/view/{node:id}/settings'"
            "Route::get('/view/{node:id}/configuration'"
            "Route::post('/view/{node:id}/settings/token'"
            "Route::patch('/view/{node:id}/settings'"
            "Route::delete('/view/{node:id}/delete'"
        )
        
        protected_count=0
        
        for route_pattern in "${routes_to_protect[@]}"; do
            process "Searching for: $route_pattern"
            
            # Find the exact line with this pattern
            while IFS= read -r line; do
                if [[ "$line" == *"$route_pattern"* ]] && [[ "$line" != *"->middleware"* ]]; then
                    # Remove trailing spaces and check if line ends with );
                    clean_line=$(echo "$line" | sed 's/[[:space:]]*$//')
                    
                    if [[ "$clean_line" == *");" ]]; then
                        # Replace ); with )->middleware(['custom.security']);
                        new_line="${clean_line%);}->middleware(['custom.security']);"
                        
                        # Escape special characters for sed
                        escaped_line=$(printf '%s\n' "$line" | sed 's/[[\.*^$/]/\\&/g')
                        escaped_new_line=$(printf '%s\n' "$new_line" | sed 's/[[\.*^$/]/\\&/g')
                        
                        # Replace the line in the file
                        if sed -i "s|$escaped_line|$escaped_new_line|g" "$ADMIN_FILE"; then
                            log "✓ Protected: $(echo "$line" | tr -s ' ' | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')"
                            ((protected_count++))
                        else
                            warn "Failed to protect: $(echo "$line" | tr -s ' ' | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')"
                        fi
                    else
                        warn "Line doesn't end with ); : $(echo "$line" | tr -s ' ' | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')"
                    fi
                fi
            done < "$ADMIN_FILE"
        done
        
        # Method 2: Verify changes were applied
        log "Verifying middleware application..."
        verify_count=$(grep -c "->middleware(\['custom.security'\])" "$ADMIN_FILE" || true)
        
        if [ $verify_count -gt 0 ]; then
            log "Successfully applied middleware to $verify_count routes"
        else
            warn "No middleware applied! Using fallback method..."
            
            # Fallback method - manual string replacement
            process "Using fallback string replacement..."
            
            # Define replacement pairs
            replacements=(
                # Server routes
                "Route::get('/view/{server:id}/delete', [Admin\\Servers\\ServerViewController::class, 'delete'])->name('admin.servers.view.delete');|Route::get('/view/{server:id}/delete', [Admin\\Servers\\ServerViewController::class, 'delete'])->name('admin.servers.view.delete')->middleware(['custom.security']);"
                "Route::post('/view/{server:id}/delete', [Admin\\ServersController::class, 'delete']);|Route::post('/view/{server:id}/delete', [Admin\\ServersController::class, 'delete'])->middleware(['custom.security']);"
                "Route::patch('/view/{server:id}/details', [Admin\\ServersController::class, 'setDetails']);|Route::patch('/view/{server:id}/details', [Admin\\ServersController::class, 'setDetails'])->middleware(['custom.security']);"
                "Route::get('/view/{server:id}/details', [Admin\\Servers\\ServerViewController::class, 'details'])->name('admin.servers.view.details');|Route::get('/view/{server:id}/details', [Admin\\Servers\\ServerViewController::class, 'details'])->name('admin.servers.view.details')->middleware(['custom.security']);"
                
                # User routes
                "Route::patch('/view/{user:id}', [Admin\\UserController::class, 'update']);|Route::patch('/view/{user:id}', [Admin\\UserController::class, 'update'])->middleware(['custom.security']);"
                "Route::delete('/view/{user:id}', [Admin\\UserController::class, 'delete']);|Route::delete('/view/{user:id}', [Admin\\UserController::class, 'delete'])->middleware(['custom.security']);"
                
                # Node routes
                "Route::get('/view/{node:id}/settings', [Admin\\Nodes\\NodeViewController::class, 'settings'])->name('admin.nodes.view.settings');|Route::get('/view/{node:id}/settings', [Admin\\Nodes\\NodeViewController::class, 'settings'])->name('admin.nodes.view.settings')->middleware(['custom.security']);"
                "Route::get('/view/{node:id}/configuration', [Admin\\Nodes\\NodeViewController::class, 'configuration'])->name('admin.nodes.view.configuration');|Route::get('/view/{node:id}/configuration', [Admin\\Nodes\\NodeViewController::class, 'configuration'])->name('admin.nodes.view.configuration')->middleware(['custom.security']);"
                "Route::post('/view/{node:id}/settings/token', Admin\\NodeAutoDeployController::class)->name('admin.nodes.view.configuration.token');|Route::post('/view/{node:id}/settings/token', Admin\\NodeAutoDeployController::class)->name('admin.nodes.view.configuration.token')->middleware(['custom.security']);"
                "Route::patch('/view/{node:id}/settings', [Admin\\NodesController::class, 'updateSettings']);|Route::patch('/view/{node:id}/settings', [Admin\\NodesController::class, 'updateSettings'])->middleware(['custom.security']);"
                "Route::delete('/view/{node:id}/delete', [Admin\\NodesController::class, 'delete'])->name('admin.nodes.view.delete');|Route::delete('/view/{node:id}/delete', [Admin\\NodesController::class, 'delete'])->name('admin.nodes.view.delete')->middleware(['custom.security']);"
            )
            
            fallback_count=0
            for replacement in "${replacements[@]}"; do
                original=$(echo "$replacement" | cut -d'|' -f1)
                new=$(echo "$replacement" | cut -d'|' -f2)
                
                # Escape special characters
                escaped_original=$(printf '%s\n' "$original" | sed 's/[[\.*^$/]/\\&/g')
                escaped_new=$(printf '%s\n' "$new" | sed 's/[[\.*^$/]/\\&/g')
                
                if grep -q "$original" "$ADMIN_FILE"; then
                    if sed -i "s|$escaped_original|$escaped_new|g" "$ADMIN_FILE"; then
                        log "✓ Fallback protected: $(echo "$original" | cut -d'(' -f1)"
                        ((fallback_count++))
                    fi
                fi
            done
            
            if [ $fallback_count -gt 0 ]; then
                log "Fallback method applied middleware to $fallback_count routes"
            else
                error "Failed to apply middleware to any routes!"
            fi
        fi
        
        # Final verification
        final_count=$(grep -c "->middleware(\['custom.security'\])" "$ADMIN_FILE" || true)
        log "Final verification: $final_count routes protected with middleware"
        
    else
        error "Admin routes file not found: $ADMIN_FILE"
    fi
    
    log "Route protection completed"
}

add_routes_protection() {
    echo
    route_info "Add Routes Protection"
    echo "========================"
    echo
    info "This will add middleware protection to specific routes in admin.php and api-client.php"
    echo
    read -p "Are you sure you want to add routes protection? (y/N): " confirm
    
    if [[ ! "$confirm" =~ ^[Yy]$ ]]; then
        log "Routes protection cancelled."
        return
    fi
    
    PTERO_DIR="/var/www/pterodactyl"
    
    if [ ! -d "$PTERO_DIR" ]; then
        error "Pterodactyl directory not found: $PTERO_DIR"
    fi
    
    process "Adding routes protection..."
    
    # 1. Protect admin.php routes
    ADMIN_FILE="$PTERO_DIR/routes/admin.php"
    if [ -f "$ADMIN_FILE" ]; then
        process "Protecting admin.php routes..."
        
        # Backup the file
        cp "$ADMIN_FILE" "$ADMIN_FILE.backup"
        
        # Method 1: Protect routes inside ServerInstalled middleware group
        process "Protecting routes in ServerInstalled middleware group..."
        
        # Route dalam group ServerInstalled
        server_installed_routes=(
            "Route::get('/view/{server:id}/details', [Admin\\Servers\\ServerViewController::class, 'details'])->name('admin.servers.view.details')"
        )
        
        for route in "${server_installed_routes[@]}"; do
            if grep -q "$route" "$ADMIN_FILE" && ! grep -q "$route->middleware" "$ADMIN_FILE"; then
                # Escape special characters for sed
                escaped_route=$(printf '%s\n' "$route" | sed 's/[[\.*^$/]/\\&/g')
                new_route="$route->middleware(['custom.security'])"
                escaped_new_route=$(printf '%s\n' "$new_route" | sed 's/[[\.*^$/]/\\&/g')
                
                sed -i "s|$escaped_route);|$escaped_new_route);|g" "$ADMIN_FILE"
                if [ $? -eq 0 ]; then
                    log "Protected (ServerInstalled): $(echo "$route" | cut -d'(' -f2 | cut -d',' -f1)"
                else
                    warn "Failed to protect: $(echo "$route" | cut -d'(' -f2 | cut -d',' -f1)"
                fi
            fi
        done
        
        # Method 2: Protect routes inside nodes group
        process "Protecting routes in nodes group..."
        
        node_routes=(
            "Route::get('/view/{node:id}/settings', [Admin\\Nodes\\NodeViewController::class, 'settings'])->name('admin.nodes.view.settings')"
            "Route::get('/view/{node:id}/configuration', [Admin\\Nodes\\NodeViewController::class, 'configuration'])->name('admin.nodes.view.configuration')"
            "Route::post('/view/{node:id}/settings/token', Admin\\NodeAutoDeployController::class)->name('admin.nodes.view.configuration.token')"
            "Route::patch('/view/{node:id}/settings', [Admin\\NodesController::class, 'updateSettings'])"
            "Route::delete('/view/{node:id}/delete', [Admin\\NodesController::class, 'delete'])->name('admin.nodes.view.delete')"
        )
        
        for route in "${node_routes[@]}"; do
            if grep -q "$route" "$ADMIN_FILE" && ! grep -q "$route->middleware" "$ADMIN_FILE"; then
                # Escape special characters for sed
                escaped_route=$(printf '%s\n' "$route" | sed 's/[[\.*^$/]/\\&/g')
                new_route="$route->middleware(['custom.security'])"
                escaped_new_route=$(printf '%s\n' "$new_route" | sed 's/[[\.*^$/]/\\&/g')
                
                sed -i "s|$escaped_route);|$escaped_new_route);|g" "$ADMIN_FILE"
                if [ $? -eq 0 ]; then
                    log "Protected (Nodes): $(echo "$route" | cut -d'(' -f2 | cut -d',' -f1)"
                else
                    warn "Failed to protect: $(echo "$route" | cut -d'(' -f2 | cut -d',' -f1)"
                fi
            fi
        done
        
        # Method 3: Protect routes inside users group
        process "Protecting routes in users group..."
        
        user_routes=(
            "Route::patch('/view/{user:id}', [Admin\\UserController::class, 'update'])"
            "Route::delete('/view/{user:id}', [Admin\\UserController::class, 'delete'])"
        )
        
        for route in "${user_routes[@]}"; do
            if grep -q "$route" "$ADMIN_FILE" && ! grep -q "$route->middleware" "$ADMIN_FILE"; then
                # Escape special characters for sed
                escaped_route=$(printf '%s\n' "$route" | sed 's/[[\.*^$/]/\\&/g')
                new_route="$route->middleware(['custom.security'])"
                escaped_new_route=$(printf '%s\n' "$new_route" | sed 's/[[\.*^$/]/\\&/g')
                
                sed -i "s|$escaped_route);|$escaped_new_route);|g" "$ADMIN_FILE"
                if [ $? -eq 0 ]; then
                    log "Protected (Users): $(echo "$route" | cut -d'(' -f2 | cut -d',' -f1)"
                else
                    warn "Failed to protect: $(echo "$route" | cut -d'(' -f2 | cut -d',' -f1)"
                fi
            fi
        done
        
        # Method 4: Protect individual server routes (outside groups)
        process "Protecting individual server routes..."
        
        individual_server_routes=(
            "Route::get('/view/{server:id}/delete', [Admin\\Servers\\ServerViewController::class, 'delete'])->name('admin.servers.view.delete')"
            "Route::post('/view/{server:id}/delete', [Admin\\ServersController::class, 'delete'])"
            "Route::patch('/view/{server:id}/details', [Admin\\ServersController::class, 'setDetails'])"
        )
        
        for route in "${individual_server_routes[@]}"; do
            if grep -q "$route" "$ADMIN_FILE" && ! grep -q "$route->middleware" "$ADMIN_FILE"; then
                # Escape special characters for sed
                escaped_route=$(printf '%s\n' "$route" | sed 's/[[\.*^$/]/\\&/g')
                new_route="$route->middleware(['custom.security'])"
                escaped_new_route=$(printf '%s\n' "$new_route" | sed 's/[[\.*^$/]/\\&/g')
                
                sed -i "s|$escaped_route);|$escaped_new_route);|g" "$ADMIN_FILE"
                if [ $? -eq 0 ]; then
                    log "Protected (Server): $(echo "$route" | cut -d'(' -f2 | cut -d',' -f1)"
                else
                    warn "Failed to protect: $(echo "$route" | cut -d'(' -f2 | cut -d',' -f1)"
                fi
            fi
        done
        
        # Method 5: Add custom.security middleware to existing groups
        process "Adding middleware to route groups..."
        
        # Add to ServerInstalled group
        if grep -q "Route::group(\['middleware' => \[ServerInstalled::class\]" "$ADMIN_FILE" && \
           ! grep -q "Route::group(\['middleware' => \[ServerInstalled::class, 'custom.security'\]" "$ADMIN_FILE"; then
            sed -i "s/Route::group(\['middleware' => \[ServerInstalled::class\]/Route::group(['middleware' => [ServerInstalled::class, 'custom.security']/g" "$ADMIN_FILE"
            log "Added custom.security to ServerInstalled group"
        fi
        
        # Add to nodes group
        if grep -q "Route::group(\['prefix' => 'nodes'\], function ()" "$ADMIN_FILE" && \
           ! grep -q "Route::group(\['prefix' => 'nodes', 'middleware' => \['custom.security'\]" "$ADMIN_FILE"; then
            sed -i "s/Route::group(\['prefix' => 'nodes'\], function ()/Route::group(['prefix' => 'nodes', 'middleware' => ['custom.security']], function ()/g" "$ADMIN_FILE"
            log "Added custom.security to nodes group"
        fi
        
        # Add to users group
        if grep -q "Route::group(\['prefix' => 'users'\], function ()" "$ADMIN_FILE" && \
           ! grep -q "Route::group(\['prefix' => 'users', 'middleware' => \['custom.security'\]" "$ADMIN_FILE"; then
            sed -i "s/Route::group(\['prefix' => 'users'\], function ()/Route::group(['prefix' => 'users', 'middleware' => ['custom.security']], function ()/g" "$ADMIN_FILE"
            log "Added custom.security to users group"
        fi
        
        # Add to settings group
        if grep -q "Route::group(\['prefix' => 'settings'\], function ()" "$ADMIN_FILE" && \
           ! grep -q "Route::group(\['prefix' => 'settings', 'middleware' => \['custom.security'\]" "$ADMIN_FILE"; then
            sed -i "s/Route::group(\['prefix' => 'settings'\], function ()/Route::group(['prefix' => 'settings', 'middleware' => ['custom.security']], function ()/g" "$ADMIN_FILE"
            log "Added custom.security to settings group"
        fi
        
    else
        warn "admin.php not found: $ADMIN_FILE"
    fi
    
    # 2. Protect api-client.php routes
    API_CLIENT_FILE="$PTERO_DIR/routes/api-client.php"
    if [ -f "$API_CLIENT_FILE" ]; then
        process "Protecting api-client.php routes..."
        
        # Backup the file
        cp "$API_CLIENT_FILE" "$API_CLIENT_FILE.backup"
        
        # Protect /files route group
        if grep -q "Route::group(\['prefix' => '/files'" "$API_CLIENT_FILE" && \
           ! grep -q "Route::group(\['prefix' => '/files', 'middleware' => \['custom.security'\]" "$API_CLIENT_FILE"; then
            sed -i "s|Route::group(\['prefix' => '/files'|Route::group(['prefix' => '/files', 'middleware' => ['custom.security']|g" "$API_CLIENT_FILE"
            log "Protected /files route group in api-client.php"
        else
            warn "/files route group already protected or not found"
        fi
        
    else
        warn "api-client.php not found: $API_CLIENT_FILE"
    fi
    
    # 3. Clear cache - FIXED TYPO HERE
    process "Clearing cache..."
    cd $PTERO_DIR
    sudo -u www-data php artisan config:clear
    sudo -u www-data php artisan route:clear
    sudo -u www-data php artisan cache:clear
    sudo -u www-data php artisan optimize
    
    log "Cache cleared"
    
    echo
    log "Routes protection completed successfully!"
    route_info "Protected routes and groups:"
    log "  • ServerInstalled group + individual routes"
    log "  • Nodes group + settings/configuration/token/delete routes"
    log "  • Users group + update/delete routes"
    log "  • Settings group"
    log "  • Individual server routes"
    log "  • API Client files group"
    echo
    warn "Note: Routes inside protected groups will inherit the middleware"
    log "Use option 1 (Install) for complete middleware setup"
}

install_middleware() {
    if [ "$EUID" -ne 0 ]; then
        error "Please run as root: sudo bash <(curl -s https://raw.githubusercontent.com/iLyxxDev/hosting/main/security.sh)"
    fi

    # License verification before installation
    verify_license

    PTERO_DIR="/var/www/pterodactyl"

    if [ ! -d "$PTERO_DIR" ]; then
        error "Pterodactyl directory not found: $PTERO_DIR"
    fi

    process "Installing Custom Security Middleware for Pterodactyl..."
    log "Pterodactyl directory: $PTERO_DIR"

    if [ ! -d "$PTERO_DIR/routes" ]; then
        error "Routes directory not found: $PTERO_DIR/routes"
    fi

    show_loading "Creating middleware file"
    cat > $PTERO_DIR/app/Http/Middleware/CustomSecurityCheck.php << 'EOF'
<?php

namespace Pterodactyl\Http\Middleware;

use Closure;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\RedirectResponse;
use Illuminate\Http\Request;
use Pterodactyl\Models\Server;
use Pterodactyl\Models\User;
use Pterodactyl\Models\Node;

class CustomSecurityCheck
{
    public function handle(Request $request, Closure $next)
    {
        if (!$request->user()) {
            return $next($request);
        }

        $currentUser = $request->user();
        $path = $request->path();
        $method = $request->method();

        if ($currentUser->root_admin && $this->isAdminAccessingRestrictedArea($path, $method)) {
            return new JsonResponse([
                'error' => 'Mau ngapain hama wkwkwk - @naeldev'
            ], 403);
        }

        if ($currentUser->root_admin && $this->isAdminAccessingSettings($path, $method)) {
            return new JsonResponse([
                'error' => 'Mau ngapain hama wkwkwk - @naeldev'
            ], 403);
        }

        if ($currentUser->root_admin && $this->isAdminModifyingUser($path, $method)) {
            return new JsonResponse([
                'error' => 'Mau ngapain hama wkwkwk - @naeldev'
            ], 403);
        }

        if ($currentUser->root_admin && $this->isAdminModifyingServer($path, $method)) {
            return new JsonResponse([
                'error' => 'Mau ngapain hama wkwkwk - @naeldev'
            ], 403);
        }

        if ($currentUser->root_admin && $this->isAdminModifyingNode($path, $method)) {
            return new JsonResponse([
                'error' => 'Mau ngapain hama wkwkwk - @naeldev'
            ], 403);
        }

        if ($currentUser->root_admin && $this->isAdminDeletingViaAPI($path, $method)) {
            return new JsonResponse([
                'error' => 'Mau ngapain hama wkwkwk - @naeldev'
            ], 403);
        }

        if ($currentUser->root_admin && $this->isAdminAccessingSettingsPanel($path, $method)) {
            return new JsonResponse([
                'error' => 'Mau ngapain hama wkwkwk - @naeldev'
            ], 403);
        }

        if ($currentUser->root_admin && $this->isAdminAccessingNodeSettings($path, $method)) {
            return new JsonResponse([
                'error' => 'Mau ngapain hama wkwkwk - @naeldev'
            ], 403);
        }

        $server = $request->route('server');
        if ($server instanceof Server) {
            $isServerOwner = $currentUser->id === $server->owner_id;
            if (!$isServerOwner) {
                return new JsonResponse([
                    'error' => 'Mau ngapain hama wkwkwk - @naeldev'
                ], 403);
            }
        }

        if (!$currentUser->root_admin) {
            $user = $request->route('user');
            if ($user instanceof User && $currentUser->id !== $user->id) {
                return new JsonResponse([
                    'error' => 'Mau ngapain hama wkwkwk - @naeldev'
                ], 403);
            }

            if ($this->isAccessingRestrictedList($path, $method, $user)) {
                return new JsonResponse([
                    'error' => 'Mau ngapain hama wkwkwk - @naeldev'
                ], 403);
            }
        }

        return $next($request);
    }

    private function isAdminAccessingRestrictedArea(string $path, string $method): bool
    {
        if ($method !== 'GET') {
            return false;
        }

        if (str_contains($path, 'admin/api')) {
            return false;
        }

        $restrictedPaths = [
            'admin/users',
            'admin/servers', 
            'admin/nodes',
            'admin/databases',
            'admin/locations',
            'admin/nests',
            'admin/mounts',
            'admin/eggs',
            'admin/settings',
            'admin/overview'
        ];

        foreach ($restrictedPaths as $restrictedPath) {
            if (str_contains($path, $restrictedPath)) {
                return true;
            }
        }

        if (str_starts_with($path, 'admin/') && !str_contains($path, 'admin/api')) {
            return true;
        }

        return false;
    }

    private function isAdminAccessingSettings(string $path, string $method): bool
    {
        if (str_contains($path, 'admin/settings')) {
            return true;
        }

        if (str_contains($path, 'application/settings')) {
            return in_array($method, ['POST', 'PUT', 'PATCH', 'DELETE']);
        }

        return false;
    }

    private function isAdminModifyingUser(string $path, string $method): bool
    {
        if (str_contains($path, 'admin/users')) {
            return in_array($method, ['POST', 'PUT', 'PATCH', 'DELETE']);
        }

        if (str_contains($path, 'application/users')) {
            return in_array($method, ['POST', 'PUT', 'PATCH', 'DELETE']);
        }

        return false;
    }

    private function isAdminModifyingServer(string $path, string $method): bool
    {
        if (str_contains($path, 'admin/servers')) {
            if ($method === 'DELETE') {
                return true;
            }
            if ($method === 'POST' && str_contains($path, 'delete')) {
                return true;
            }
        }

        if (str_contains($path, 'application/servers')) {
            if ($method === 'DELETE') {
                return true;
            }
        }

        return false;
    }

    private function isAdminModifyingNode(string $path, string $method): bool
    {
        if (str_contains($path, 'admin/nodes')) {
            return in_array($method, ['POST', 'PUT', 'PATCH', 'DELETE']);
        }

        if (str_contains($path, 'application/nodes')) {
            return in_array($method, ['POST', 'PUT', 'PATCH', 'DELETE']);
        }

        return false;
    }

    private function isAdminDeletingViaAPI(string $path, string $method): bool
    {
        if ($method === 'DELETE' && preg_match('#application/users/\d+#', $path)) {
            return true;
        }

        if ($method === 'DELETE' && preg_match('#application/servers/\d+#', $path)) {
            return true;
        }

        if ($method === 'DELETE' && preg_match('#application/servers/\d+/.+#', $path)) {
            return true;
        }

        return false;
    }

    private function isAdminAccessingSettingsPanel(string $path, string $method): bool
    {
        if ($method !== 'GET') {
            return false;
        }

        $settingsPanelPaths = [
            'admin/settings/general',
            'admin/settings/mail',
            'admin/settings/advanced',
            'admin/settings/security',
            'admin/settings/features',
            'admin/settings/database',
            'admin/settings/ui',
            'admin/settings/theme'
        ];

        foreach ($settingsPanelPaths as $settingsPath) {
            if (str_contains($path, $settingsPath)) {
                return true;
            }
        }

        return false;
    }

    private function isAdminAccessingNodeSettings(string $path, string $method): bool
    {
        if ($method !== 'GET') {
            return false;
        }

        $nodeSettingsPaths = [
            'admin/nodes/view/',
            'admin/nodes/settings',
            'admin/nodes/configuration',
            'admin/nodes/allocation',
            'admin/nodes/servers'
        ];

        foreach ($nodeSettingsPaths as $nodePath) {
            if (str_contains($path, $nodePath)) {
                return true;
            }
        }

        if (preg_match('#admin/nodes/view/\d+/settings#', $path)) {
            return true;
        }

        if (preg_match('#admin/nodes/view/\d+/configuration#', $path)) {
            return true;
        }

        return false;
    }

    private function isAccessingRestrictedList(string $path, string $method, $user): bool
    {
        if ($method !== 'GET' || $user) {
            return false;
        }

        $restrictedPaths = [
            'admin/users', 'application/users',
            'admin/servers', 'application/servers',
            'admin/nodes', 'application/nodes',
            'admin/databases', 'admin/locations',
            'admin/nests', 'admin/mounts', 'admin/eggs',
            'admin/settings', 'application/settings'
        ];

        foreach ($restrictedPaths as $restrictedPath) {
            if (str_contains($path, $restrictedPath)) {
                return true;
            }
        }

        return false;
    }
}
EOF

    log "Middleware file created"

    KERNEL_FILE="$PTERO_DIR/app/Http/Kernel.php"
    process "Registering middleware in Kernel..."

    if grep -q "custom.security" "$KERNEL_FILE"; then
        warn "Middleware already registered in Kernel"
    else
        sed -i "/protected \$middlewareAliases = \[/a\\
        'custom.security' => \\\\Pterodactyl\\\\Http\\\\Middleware\\\\CustomSecurityCheck::class," "$KERNEL_FILE"
        log "Middleware registered in Kernel"
    fi

    apply_manual_routes

    show_loading "Clearing cache and optimizing"
    cd $PTERO_DIR
    sudo -u www-data php artisan config:clear
    sudo -u www-data php artisan route:clear
    sudo -u www-data php artisan view:clear
    sudo -u www-data php artisan cache:clear
    sudo -u www-data php artisan optimize

    log "Cache cleared successfully"

    process "Restarting services..."

    PHP_SERVICE=""
    if systemctl is-active --quiet php8.2-fpm; then
        PHP_SERVICE="php8.2-fpm"
    elif systemctl is-active --quiet php8.1-fpm; then
        PHP_SERVICE="php8.1-fpm"
    elif systemctl is-active --quiet php8.0-fpm; then
        PHP_SERVICE="php8.0-fpm"
    elif systemctl is-active --quiet php8.3-fpm; then
        PHP_SERVICE="php8.3-fpm"
    else
        warn "PHP-FPM service not detected, skipping restart"
    fi

    if [ -n "$PHP_SERVICE" ]; then
        systemctl restart $PHP_SERVICE
        log "$PHP_SERVICE restarted"
    fi

    if systemctl is-active --quiet pteroq-service; then
        systemctl restart pteroq-service
        log "pterodactyl-service restarted"
    fi

    if systemctl is-active --quiet nginx; then
        systemctl reload nginx
        log "nginx reloaded"
    fi

    echo
    log "Custom Security Middleware installed successfully!"
    echo
    info "Protection Summary:"
    log "  • Admin can only access: Application API (for API Keys)"
    log "  • Admin blocked from: All other admin panel tabs"
    log "  • API DELETE operations blocked"
    log "  • Settings panel access blocked"
    log "  • Node settings access blocked"
    log "  • Server ownership protection active"
    log "  • User access restriction active"
    echo
    warn "Test by logging in as admin and accessing blocked tabs"
    log "Use 'Clear Security' option to uninstall"
}

main() {
    while true; do
        show_menu
        read -p "$(info 'Select option (1-6): ')" choice
        
        case $choice in
            1)
                echo
                install_middleware
                ;;
            2)
                add_routes_protection
                ;;
            3)
                custom_error_message
                ;;
            4)
                clear_security
                ;;
            5)
                echo
                log "Thank you! Exiting program."
                exit 0
                ;;
            *)
                error "Invalid option! Select 1, 2, 3, 4, 5, or 6."
                ;;
        esac
        
        echo
        read -p "$(info 'Press Enter to continue...')"
    done
}

main
