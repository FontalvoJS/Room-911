import { ref } from "vue";

export function useThrottle(fn, delay) {
    const isThrottled = ref(false); // Almacena el estado de la función (si está en espera o no)

    return function (...args) {
        if (isThrottled.value) {
            return; // Si la función está en espera, no hacer nada
        }

        isThrottled.value = true; // Poner la función en espera

        // Usamos fn.apply para asegurar que 'this' y los argumentos se pasen correctamente
        fn.apply(this, args); 

        setTimeout(() => {
            isThrottled.value = false; // Quitar la espera después del delay
        }, delay);
    };
}
