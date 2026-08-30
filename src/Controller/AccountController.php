<?php

namespace App\Controller;

use App\Form\UserFormType;
use DateTimeImmutable;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Attribute\Route;
use Symfony\Contracts\Translation\TranslatorInterface;

final class AccountController extends AbstractController
{

    #[Route('/account', name: 'app_account')]
    public function index(TranslatorInterface $translator): Response
    {
        if (!$this->getUser()) {
            $this->addFlash("error", $translator->trans("accountController.account.NotConnected"));
            return $this->redirectToRoute("app_home");
        }

        return $this->render('account/index.html.twig', [
            'controller_name' => 'AccountController',
        ]);
    }

    #[Route('/account/edit', name: "app_account_edit")]
    public function edit(
        Request $request,
        EntityManagerInterface $em,
        TranslatorInterface $translator
    ): Response {

        if (!$this->getUser()) {
            $this->addFlash("error", $translator->trans("accountController.edit.NotConnected"));
            return $this->redirectToRoute("app_home");
        }

        /**
         * @var User
         */
        $user = $this->getUser();
        $form = $this->createForm(UserFormType::class, $user);
        $form->handleRequest($request);
        if ($form->isSubmitted() && $form->isValid()) {
            $user->setUpdatedAt(new DateTimeImmutable());
            $em->flush();
            $this->addFlash('success', $translator->trans('Account successfuly updated !'));
            return $this->redirectToRoute('app_account');
        }
        return $this->render('account/edit.html.twig', [
            'user' => $user,
            'usermonForm' => $form->createView()
        ]);
    }
}
