import { initializeApp } from "https://www.gstatic.com/firebasejs/12.3.0/firebase-app.js";
import {
    getDatabase,
    ref,
    push,
    set
} from "https://www.gstatic.com/firebasejs/12.3.0/firebase-database.js";

const firebaseConfig = {
    apiKey: "AIzaSyBB1bea0rot_DrEOQPvmcgajIw5g9fJGls",
    authDomain: "urbeco2026.firebaseapp.com",
    databaseURL: "https://urbeco2026-default-rtdb.firebaseio.com",
    projectId: "urbeco2026",
    storageBucket: "urbeco2026.firebasestorage.app",
    messagingSenderId: "243928007368",
    appId: "1:243928007368:web:f9deb0395bdc141ede1bfd",
    measurementId: "G-KZ0R78PNLE"
};

const app = initializeApp(firebaseConfig);

const database = getDatabase(app);


const form = document.getElementById("feedback-form");

const nomeInput = document.getElementById("feedback-nome");
const emailInput = document.getElementById("feedback-contato");
const mensagemInput = document.getElementById("feedback-mensagem");

const erro = document.getElementById("feedback-erro");
const sucesso = document.getElementById("feedback-success");

form.addEventListener("submit", async function (event) {

    event.preventDefault();

    erro.textContent = "";

    const nome = nomeInput.value.trim();
    const email = emailInput.value.trim();
    const mensagem = mensagemInput.value.trim();

    const tipoSelecionado = document.querySelector(
        'input[name="tipo"]:checked'
    );

    const assunto = tipoSelecionado ? tipoSelecionado.value : "Bug";


    if (mensagem.length === 0) {
        erro.textContent = "Digite uma mensagem antes de enviar.";
        mensagemInput.focus();
        return;
    }


    try {
        const feedbacksRef = ref(database, "Mensagens");
        const novoFeedbackRef = push(feedbacksRef);
        const id = novoFeedbackRef.key;

        const feedback = {
            Id: id,
            Nome: nome,
            Email: email,
            Assunto: assunto,
            Finalizado: false,
            Mensagem: mensagem
        };


        await set(novoFeedbackRef, feedback);

        form.reset();

        sucesso.hidden = false;

        console.log("Feedback enviado:", feedback);

    } catch (error) {

        console.error("Erro ao enviar feedback:", error);

        erro.textContent =
            "Não foi possível enviar o feedback. Tente novamente.";
    }
});
