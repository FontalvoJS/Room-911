@extends('layouts.app')

@section('content')
    <div class="container py-5">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h1 class="h3">Administrative Menu</h1>
            <div>
                <span><strong>Current Time:</strong><small id="currentTime"></small></span>
                <span class="ms-3 text-capitalize"><strong>Welcome:</strong> {{ Auth::user()->name }}</span>
            </div>
        </div>
        <dashboard-component></dashboard-component>
    </div>
    <script>
        function showTime() {
            // Crear una instancia del objeto Date
            const now = new Date();

            // Obtener la hora, minutos y segundos
            let hours = now.getHours();
            let minutes = now.getMinutes();
            let seconds = now.getSeconds();

            // Formato AM/PM (opcional)
            let ampm = hours >= 12 ? 'PM' : 'AM';
            hours = hours % 12;
            hours = hours ? hours : 12; // Si la hora es 0, se cambia a 12

            // Añadir un 0 al frente de los minutos y segundos si es necesario
            minutes = minutes < 10 ? '0' + minutes : minutes;
            seconds = seconds < 10 ? '0' + seconds : seconds;

            // Formatear la hora actual
            const currentTime = hours + ':' + minutes + ':' + seconds + ' ' + ampm;

            // Mostrar la hora en el elemento con el id "clock"
            document.getElementById('currentTime').textContent = currentTime;
        }
        setInterval(() => {
            showTime();
        }, 1000);
    </script>
@endsection
