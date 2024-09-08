import { ref } from "vue";

export function useThrottle(fn, delay) {
    const isThrottled = ref(false); // Almacena el estado de la función (si está en espera o no)

    return async function (...args) {
        if (isThrottled.value) {
            return; // Si la función está en espera, no hacer nada
        }

        isThrottled.value = true; // Poner la función en espera

        fn(...args); // Esperar a que la función original termine

        setTimeout(() => {
            isThrottled.value = false; // Quitar la espera después del delay
        }, delay);
    };
}
