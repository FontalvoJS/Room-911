/**
 * First we will load all of this project's JavaScript dependencies which
 * includes Vue and other libraries. It is a great starting point when
 * building robust, powerful web applications using Vue and Laravel.
 */

// import "./bootstrap";
import { createApp } from "vue";
import Toast from "vue-toastification";
import "vue-toastification/dist/index.css"; // Importar los estilos de Toastification
import { createRouter, createWebHistory } from "vue-router";

/**
 * Next, we will create a fresh Vue application instance. You may then begin
 * registering components with the application instance so they are ready
 * to use in your application's views. An example is included for you.
 */

const app = createApp({});

import LoginComponent from "./components/LoginComponent.vue";
import DashboardComponent from "./components/DashboardComponent.vue";
app.component("login-component", LoginComponent);
app.component("dashboard-component", DashboardComponent);
/**
 * The following block of code may be used to automatically register your
 * Vue components. It will recursively scan this directory for the Vue
 * components and automatically register them with their "basename".
 *
 * Eg. ./components/ExampleComponent.vue -> <example-component></example-component>
 */

// Object.entries(import.meta.glob('./**/*.vue', { eager: true })).forEach(([path, definition]) => {
//     app.component(path.split('/').pop().replace(/\.\w+$/, ''), definition.default);
// });

/**
 * Finally, we will attach the application instance to a HTML element with
 * an "id" attribute of "app". This element is included with the "auth"
 * scaffolding. Otherwise, you will need to add an element yourself.
 */
// Configurar la biblioteca de Toast
const options = {
    // Opciones de configuración
    position: "top-right",
    timeout: 5000,
    closeOnClick: true,
    pauseOnHover: true,
    draggable: true,
    draggablePercent: 0.6,
    showCloseButtonOnHover: false,
    closeButton: "button",
    hideProgressBar: false,
    icon: true,
};

const routes = [
    {
        path: "/",
        name: "home",
    },
    {
        path: "/login",
        name: "login",
        component: LoginComponent,
    },
    {
        path: "/dashboard",
        name: "dashboard",
        component: DashboardComponent,
    },
];

// Crear el router
const router = createRouter({
    history: createWebHistory(),
    routes,
});

// Agregar el router a la aplicación
app.use(router);

app.use(Toast, options);

app.mount("#app");
